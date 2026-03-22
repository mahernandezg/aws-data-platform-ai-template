# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: ISC Glue job starter that lands ingested data into Apache Iceberg with explicit runtime configuration placeholders.

"""
Architecture component: ISC - Ingestion Service Center
Environment applicability: DIT, DEV, QA, PPRD, PRD
Notes:
- This starter assumes IAM Roles only.
- This starter assumes Apache Iceberg is the mandatory table format from ISC onward.
- This starter is intentionally near-runnable and expects job arguments, catalog configuration, and source parsing logic to be completed by the implementing team.
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
    "target_database",
    "target_table",
    "warehouse_path",
]


def configure_spark(glue_context: GlueContext, warehouse_path: str) -> None:
    spark = glue_context.spark_session
    spark.conf.set("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions")
    spark.conf.set("spark.sql.catalog.platform_catalog", "org.apache.iceberg.spark.SparkCatalog")
    spark.conf.set("spark.sql.catalog.platform_catalog.catalog-impl", "org.apache.iceberg.aws.glue.GlueCatalog")
    spark.conf.set("spark.sql.catalog.platform_catalog.io-impl", "org.apache.iceberg.aws.s3.S3FileIO")
    spark.conf.set("spark.sql.catalog.platform_catalog.warehouse", warehouse_path)


def extract_source(glue_context: GlueContext, source_path: str):
    spark = glue_context.spark_session

    # Replace this read pattern with the source-specific parser required by the ingestion use case.
    return (
        spark.read.json(source_path)
        .withColumn("ingestion_timestamp_utc", F.current_timestamp())
        .withColumn("record_source_path", F.input_file_name())
    )


def load_to_iceberg(dataframe, target_database: str, target_table: str) -> None:
    target_identifier = f"platform_catalog.{target_database}.{target_table}"

    # ISC standardizes data into Apache Iceberg. Downstream processing and distribution
    # should consume the resulting managed table rather than ad hoc file outputs.
    (
        dataframe.writeTo(target_identifier)
        .tableProperty("format-version", "2")
        .option("fanout-enabled", "true")
        .createOrReplace()
    )


def main() -> None:
    args = getResolvedOptions(sys.argv, REQUIRED_ARGS)

    spark_context = SparkContext.getOrCreate()
    glue_context = GlueContext(spark_context)
    job = Job(glue_context)
    job.init(args["JOB_NAME"], args)

    configure_spark(glue_context, args["warehouse_path"])
    source_df = extract_source(glue_context, args["source_path"])
    load_to_iceberg(source_df, args["target_database"], args["target_table"])

    job.commit()


if __name__ == "__main__":
    main()
