# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: DP-EH PySpark starter for the ingestion-s3-to-iceberg-spark example that transforms ISC Landing Zone data into Bronze, Silver, and Gold Apache Iceberg tables.

"""
Architecture component: DP-EH - Data Processing Center - Enterprise Hub
Environment applicability: DIT, DEV, QA, PPRD, PRD
Use case: examples/ingestion-s3-to-iceberg-spark
Notes:
- ISC owns the Landing Zone only.
- This job owns Bronze, Silver, and Gold processing for the example.
- DDC exposes only the Gold table through Athena in the default pattern.
- Runtime identity is assumed to be an IAM Role.
"""

import argparse
import logging

from pyspark.sql import SparkSession, functions as F


LOGGER = logging.getLogger("dp_eh_orders_medallion_job")


def build_argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="DP-EH S3 to Iceberg Spark example")
    parser.add_argument("--source-path", required=True)
    parser.add_argument("--warehouse-path", required=True)
    parser.add_argument("--bronze-database", required=True)
    parser.add_argument("--silver-database", required=True)
    parser.add_argument("--gold-database", required=True)
    parser.add_argument("--table-prefix", required=True)
    return parser


def build_spark_session(warehouse_path: str) -> SparkSession:
    return (
        SparkSession.builder.appName("dp-eh-orders-medallion-job")
        .config("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions")
        .config("spark.sql.catalog.platform_catalog", "org.apache.iceberg.spark.SparkCatalog")
        .config("spark.sql.catalog.platform_catalog.catalog-impl", "org.apache.iceberg.aws.glue.GlueCatalog")
        .config("spark.sql.catalog.platform_catalog.io-impl", "org.apache.iceberg.aws.s3.S3FileIO")
        .config("spark.sql.catalog.platform_catalog.warehouse", warehouse_path)
        .getOrCreate()
    )


def read_landing_data(spark: SparkSession, source_path: str):
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
    logging.basicConfig(level=logging.INFO)
    args = build_argument_parser().parse_args()

    spark = build_spark_session(args.warehouse_path)

    LOGGER.info("Starting Spark Medallion example from Landing Zone input: %s", args.source_path)

    landing_df = read_landing_data(spark, args.source_path)
    bronze_df = build_bronze(landing_df)
    silver_df = build_silver(bronze_df)
    gold_df = build_gold(silver_df)

    write_table(bronze_df, args.bronze_database, f"{args.table_prefix}_bronze")
    write_table(silver_df, args.silver_database, f"{args.table_prefix}_silver")
    write_table(gold_df, args.gold_database, f"{args.table_prefix}_gold")

    LOGGER.info("Completed Spark Medallion example for table prefix: %s", args.table_prefix)
    spark.stop()


if __name__ == "__main__":
    main()
