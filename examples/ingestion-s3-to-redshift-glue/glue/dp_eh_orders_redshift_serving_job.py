# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: DP-EH Glue starter for the ingestion-s3-to-redshift-glue example that transforms ISC Landing Zone data into Bronze, Silver, and enterprise Gold Apache Iceberg tables and prepares an incremental Gold-serving extract for DDC Redshift loading.

"""
Architecture component: DP-EH - Data Processing Center - Enterprise Hub
Environment applicability: DIT, DEV, QA, PPRD, PRD
Use case: examples/ingestion-s3-to-redshift-glue
Notes:
- ISC owns the Landing Zone only.
- This job owns Bronze, Silver, and enterprise Gold processing for the example.
- DDC serves the final Gold Data Product in Redshift after a controlled S3 staging step.
- Runtime identity is assumed to be an IAM Role.
"""

import sys
from datetime import datetime, timezone

from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from pyspark.sql import functions as F


REQUIRED_ARGS = [
    "JOB_NAME",
    "source_path",
    "bronze_database",
    "silver_database",
    "gold_database",
    "table_prefix",
    "warehouse_path",
    "redshift_stage_path",
    "redshift_database",
    "redshift_schema",
    "redshift_copy_role_arn",
]


def configure_spark(glue_context: GlueContext, warehouse_path: str) -> None:
    spark = glue_context.spark_session
    spark.conf.set("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions")
    spark.conf.set("spark.sql.catalog.platform_catalog", "org.apache.iceberg.spark.SparkCatalog")
    spark.conf.set("spark.sql.catalog.platform_catalog.catalog-impl", "org.apache.iceberg.aws.glue.GlueCatalog")
    spark.conf.set("spark.sql.catalog.platform_catalog.io-impl", "org.apache.iceberg.aws.s3.S3FileIO")
    spark.conf.set("spark.sql.catalog.platform_catalog.warehouse", warehouse_path)


def read_landing_data(glue_context: GlueContext, source_path: str):
    spark = glue_context.spark_session
    return (
        spark.read.json(source_path)
        .withColumn("landing_timestamp_utc", F.current_timestamp())
        .withColumn("landing_source_path", F.input_file_name())
    )


def write_iceberg_table(dataframe, database_name: str, table_name: str) -> None:
    identifier = f"platform_catalog.{database_name}.{table_name}"
    (
        dataframe.writeTo(identifier)
        .tableProperty("format-version", "2")
        .option("fanout-enabled", "true")
        .createOrReplace()
    )


def read_existing_gold_table(glue_context: GlueContext, database_name: str, table_name: str):
    identifier = f"platform_catalog.{database_name}.{table_name}"
    try:
        return glue_context.spark_session.table(identifier)
    except Exception:
        return None


def build_bronze(landing_df):
    return landing_df.withColumn("medallion_layer", F.lit("bronze"))


def build_silver(bronze_df):
    return (
        bronze_df.filter(F.col("order_id").isNotNull())
        .withColumn("order_status_normalized", F.lower(F.col("order_status")))
        .withColumn("order_amount", F.col("order_amount").cast("decimal(18,2)"))
        .withColumn("medallion_layer", F.lit("silver"))
    )


def build_gold_increment(silver_df):
    return (
        silver_df.groupBy("customer_id")
        .agg(
            F.countDistinct("order_id").alias("order_count"),
            F.sum("order_amount").alias("total_order_amount"),
            F.max("landing_timestamp_utc").alias("last_order_timestamp_utc"),
        )
        .withColumn("data_product_name", F.lit("customer_order_summary"))
        .withColumn("medallion_layer", F.lit("gold"))
    )


def reconcile_gold_snapshot(existing_gold_df, gold_increment_df):
    if existing_gold_df is None:
        return gold_increment_df, gold_increment_df

    affected_customers_df = gold_increment_df.select("customer_id").distinct()
    unchanged_gold_df = existing_gold_df.join(affected_customers_df, "customer_id", "left_anti")
    existing_affected_gold_df = existing_gold_df.join(affected_customers_df, "customer_id", "inner")

    serving_increment_df = (
        existing_affected_gold_df.unionByName(gold_increment_df)
        .groupBy("customer_id")
        .agg(
            F.sum("order_count").cast("integer").alias("order_count"),
            F.sum("total_order_amount").cast("decimal(18,2)").alias("total_order_amount"),
            F.max("last_order_timestamp_utc").alias("last_order_timestamp_utc"),
        )
        .withColumn("data_product_name", F.lit("customer_order_summary"))
        .withColumn("medallion_layer", F.lit("gold"))
    )

    full_gold_snapshot_df = unchanged_gold_df.unionByName(serving_increment_df)
    return full_gold_snapshot_df, serving_increment_df


def write_redshift_stage_extract(gold_df, redshift_stage_path: str, batch_id: str):
    stage_df = (
        gold_df.withColumn("load_batch_id", F.lit(batch_id))
        .withColumn("load_timestamp_utc", F.current_timestamp())
    )

    target_path = f"{redshift_stage_path.rstrip('/')}/load_batch_id={batch_id}/"
    (
        stage_df.write.mode("overwrite")
        .option("compression", "snappy")
        .parquet(target_path)
    )
    return target_path


def build_redshift_sql(redshift_database: str, redshift_schema: str, table_prefix: str, staged_s3_path: str, redshift_copy_role_arn: str) -> str:
    target_table = f"{table_prefix}_gold"
    stage_table = f"{table_prefix}_gold_stage"

    return f"""
create table if not exists {redshift_database}.{redshift_schema}.{target_table} (
    customer_id varchar(256),
    order_count integer,
    total_order_amount decimal(18,2),
    last_order_timestamp_utc timestamp,
    data_product_name varchar(256),
    medallion_layer varchar(32),
    load_batch_id varchar(64),
    load_timestamp_utc timestamp
);

create table if not exists {redshift_database}.{redshift_schema}.{stage_table} (
    customer_id varchar(256),
    order_count integer,
    total_order_amount decimal(18,2),
    last_order_timestamp_utc timestamp,
    data_product_name varchar(256),
    medallion_layer varchar(32),
    load_batch_id varchar(64),
    load_timestamp_utc timestamp
);

truncate table {redshift_database}.{redshift_schema}.{stage_table};

copy {redshift_database}.{redshift_schema}.{stage_table}
from '{staged_s3_path}'
iam_role '{redshift_copy_role_arn}'
format as parquet;

merge into {redshift_database}.{redshift_schema}.{target_table} as target
using {redshift_database}.{redshift_schema}.{stage_table} as source
on target.customer_id = source.customer_id
when matched then update set
    order_count = source.order_count,
    total_order_amount = source.total_order_amount,
    last_order_timestamp_utc = source.last_order_timestamp_utc,
    data_product_name = source.data_product_name,
    medallion_layer = source.medallion_layer,
    load_batch_id = source.load_batch_id,
    load_timestamp_utc = source.load_timestamp_utc
when not matched then insert (
    customer_id,
    order_count,
    total_order_amount,
    last_order_timestamp_utc,
    data_product_name,
    medallion_layer,
    load_batch_id,
    load_timestamp_utc
) values (
    source.customer_id,
    source.order_count,
    source.total_order_amount,
    source.last_order_timestamp_utc,
    source.data_product_name,
    source.medallion_layer,
    source.load_batch_id,
    source.load_timestamp_utc
);
""".strip()


def main() -> None:
    args = getResolvedOptions(sys.argv, REQUIRED_ARGS)

    spark_context = SparkContext.getOrCreate()
    glue_context = GlueContext(spark_context)
    job = Job(glue_context)
    job.init(args["JOB_NAME"], args)

    configure_spark(glue_context, args["warehouse_path"])

    batch_id = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    landing_df = read_landing_data(glue_context, args["source_path"])
    bronze_df = build_bronze(landing_df)
    silver_df = build_silver(bronze_df)
    gold_increment_df = build_gold_increment(silver_df)
    existing_gold_df = read_existing_gold_table(glue_context, args["gold_database"], f"{args['table_prefix']}_gold")
    gold_df, serving_increment_df = reconcile_gold_snapshot(existing_gold_df, gold_increment_df)

    write_iceberg_table(bronze_df, args["bronze_database"], f"{args['table_prefix']}_bronze")
    write_iceberg_table(silver_df, args["silver_database"], f"{args['table_prefix']}_silver")
    write_iceberg_table(gold_df, args["gold_database"], f"{args['table_prefix']}_gold")

    staged_s3_path = write_redshift_stage_extract(serving_increment_df, args["redshift_stage_path"], batch_id)
    redshift_sql = build_redshift_sql(
        args["redshift_database"],
        args["redshift_schema"],
        args["table_prefix"],
        staged_s3_path,
        args["redshift_copy_role_arn"],
    )

    print(f"Prepared Redshift stage extract at: {staged_s3_path}")
    print("Run the following DDC Redshift load SQL after Glue completes:")
    print(redshift_sql)

    job.commit()


if __name__ == "__main__":
    main()
