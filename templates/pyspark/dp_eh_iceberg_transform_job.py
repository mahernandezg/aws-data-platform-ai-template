# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: DP-EH PySpark starter that transforms Iceberg-managed inputs into a curated Apache Iceberg output with clear configuration placeholders.

"""
Architecture component: DP-EH - Data Processing Center - Enterprise Hub
Environment applicability: DIT, DEV, QA, PPRD, PRD
Notes:
- This starter assumes IAM Roles only.
- This starter assumes Apache Iceberg is the mandatory table format from ISC onward.
- This starter is written for enterprise-scale centralized processing, not DDC serving logic.
- Extend the starter with explicit lineage and observability integration rather than hiding those concerns in undocumented helper code.
"""

import argparse
import logging

from pyspark.sql import SparkSession, functions as F


LOGGER = logging.getLogger("dp_eh_iceberg_transform_job")


def build_argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="DP-EH Iceberg transformation starter")
    parser.add_argument("--warehouse-path", required=True)
    parser.add_argument("--source-database", required=True)
    parser.add_argument("--source-table", required=True)
    parser.add_argument("--target-database", required=True)
    parser.add_argument("--target-table", required=True)
    return parser


def build_spark_session(warehouse_path: str) -> SparkSession:
    return (
        SparkSession.builder.appName("dp-eh-iceberg-transform-job")
        .config("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions")
        .config("spark.sql.catalog.platform_catalog", "org.apache.iceberg.spark.SparkCatalog")
        .config("spark.sql.catalog.platform_catalog.catalog-impl", "org.apache.iceberg.aws.glue.GlueCatalog")
        .config("spark.sql.catalog.platform_catalog.io-impl", "org.apache.iceberg.aws.s3.S3FileIO")
        .config("spark.sql.catalog.platform_catalog.warehouse", warehouse_path)
        .getOrCreate()
    )


def read_source_table(spark: SparkSession, source_database: str, source_table: str):
    source_identifier = f"platform_catalog.{source_database}.{source_table}"
    return spark.table(source_identifier)


def transform(source_df):
    # Keep lineage-relevant columns visible. Avoid transformations that make source provenance opaque.
    return (
        source_df.withColumn("processed_timestamp_utc", F.current_timestamp())
        .withColumn("record_status", F.lit("curated"))
    )


def write_target_table(curated_df, target_database: str, target_table: str) -> None:
    target_identifier = f"platform_catalog.{target_database}.{target_table}"

    # Observability and lineage extensions typically emit metrics, logs, or audit events here.
    # Keep that integration explicit rather than hiding it in utility modules with unclear ownership.
    (
        curated_df.writeTo(target_identifier)
        .tableProperty("format-version", "2")
        .option("fanout-enabled", "true")
        .createOrReplace()
    )


def main() -> None:
    logging.basicConfig(level=logging.INFO)
    args = build_argument_parser().parse_args()

    spark = build_spark_session(args.warehouse_path)
    LOGGER.info("Starting DP-EH Iceberg transform for %s.%s", args.source_database, args.source_table)

    source_df = read_source_table(spark, args.source_database, args.source_table)
    curated_df = transform(source_df)

    # Emit workload metrics, audit markers, or lineage events here if your implementation
    # integrates with a shared DCS observability baseline.
    write_target_table(curated_df, args.target_database, args.target_table)

    LOGGER.info("Completed DP-EH Iceberg transform for %s.%s", args.target_database, args.target_table)
    spark.stop()


if __name__ == "__main__":
    main()
