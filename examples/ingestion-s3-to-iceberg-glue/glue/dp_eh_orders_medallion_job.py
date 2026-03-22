# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: DP-EH Glue starter for the ingestion-s3-to-iceberg example that transforms ISC Landing Zone data into Bronze, Silver, and Gold Apache Iceberg tables.

"""
Architecture component: DP-EH - Data Processing Center - Enterprise Hub
Environment applicability: DIT, DEV, QA, PPRD, PRD
Use case: examples/ingestion-s3-to-iceberg
Notes:
- ISC owns the Landing Zone only.
- This job owns Bronze, Silver, and Gold processing for the example.
- DDC exposes only the Gold table through Athena in the default pattern.
- Runtime identity is assumed to be an IAM Role.
"""

import sys

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

    # Replace this parser with the source-specific schema required by the actual ingestion flow.
    return (
        spark.read.json(source_path)
        .withColumn("landing_timestamp_utc", F.current_timestamp())
        .withColumn("landing_source_path", F.input_file_name())
    )


def write_table(dataframe, database_name: str, table_name: str) -> None:
    identifier = f"platform_catalog.{database_name}.{table_name}"
    (
        dataframe.writeTo(identifier)
        .tableProperty("format-version", "2")
        .option("fanout-enabled", "true")
        .createOrReplace()
    )


def build_bronze(landing_df):
    return landing_df.withColumn("record_status", F.lit("bronze"))


def build_silver(bronze_df):
    return (
        bronze_df.filter(F.col("event_id").isNotNull())
        .withColumn("record_status", F.lit("silver"))
        .withColumn("event_type_normalized", F.lower(F.col("event_type")))
    )


def build_gold(silver_df):
    return (
        silver_df.groupBy("event_type_normalized")
        .agg(F.count("*").alias("event_count"))
        .withColumn("record_status", F.lit("gold"))
        .withColumn("data_product_name", F.lit("orders_event_summary"))
    )


def main() -> None:
    args = getResolvedOptions(sys.argv, REQUIRED_ARGS)

    spark_context = SparkContext.getOrCreate()
    glue_context = GlueContext(spark_context)
    job = Job(glue_context)
    job.init(args["JOB_NAME"], args)

    configure_spark(glue_context, args["warehouse_path"])

    landing_df = read_landing_data(glue_context, args["source_path"])
    bronze_df = build_bronze(landing_df)
    silver_df = build_silver(bronze_df)
    gold_df = build_gold(silver_df)

    write_table(bronze_df, args["bronze_database"], f"{args['table_prefix']}_bronze")
    write_table(silver_df, args["silver_database"], f"{args['table_prefix']}_silver")
    write_table(gold_df, args["gold_database"], f"{args['table_prefix']}_gold")

    job.commit()


if __name__ == "__main__":
    main()
