# Ingestion S3 to Iceberg Spark Example

This example is a compact end-to-end reference for a public AWS Data Platform implementation pattern built from the repository architecture system.

It demonstrates:

- ISC ingestion into an S3 Landing Zone
- DP-EH Medallion processing with Apache Iceberg
- Spark-based processing handoff through a PySpark job
- DDC Gold exposure through Amazon Athena
- IAM role-only assumptions from end to end

## Purpose

This example is intended to be a Spark-oriented companion to the Glue-based ingestion-to-Iceberg example.

It is deliberately small, but it still reinforces the repository's non-negotiable standards:

- IAM Roles only
- Apache Iceberg from ISC onward
- Medallion layer ownership from Landing Zone through Gold
- Redshift not used as a processing engine
- DDC exposing Gold only to consumers in the default pattern

## Architecture Scope

This example covers the following component path:

- ISC for Landing Zone ingestion
- DP-EH for Bronze, Silver, and Gold processing
- DDC for Gold exposure through Athena

It does not use DP-SP because the goal is to teach the platform baseline with minimal spoke-specific variation.

## Folder Structure

```text
examples/ingestion-s3-to-iceberg-spark/
|-- README.md
|-- architecture-note.md
|-- environments.md
|-- terraform/
|   |-- main.tf
|   |-- variables.tf
|   `-- outputs.tf
`-- pyspark/
    `-- dp_eh_orders_medallion_job.py
```

## Medallion Mapping

This example enforces the repository Medallion model as follows:

- ISC: Landing Zone only
- DP-EH Bronze: standardized raw table
- DP-EH Silver: cleansed and structured table
- DP-EH Gold: final Data Product table for downstream use
- DDC: Athena exposure of the Gold table only

This example does not use the AI-oriented exception for Bronze or Silver access.

## What the Terraform Starter Provides

The Terraform starter is near-runnable and provisions a minimal baseline for the example:

- S3 Landing Zone bucket for ISC
- S3 warehouse bucket for Iceberg-managed tables
- Glue Catalog databases for Bronze, Silver, and Gold
- Athena workgroup for DDC exposure
- one IAM role-only runtime pattern for a DP-EH Spark job

The example assumes AWS IAM Roles only. It does not create IAM Users.

## What the PySpark Starter Does

The PySpark starter is a single DP-EH job that:

1. reads a source file from the ISC Landing Zone
2. writes a Bronze Iceberg table
3. derives a Silver Iceberg table
4. derives a Gold Iceberg table

This keeps the example compact while still making the Medallion progression explicit.

## Example Teaching Value

This example is designed to be:

- easy to explain to a new engineer
- reusable as a first Spark-based accelerator pattern
- aligned to the repository architecture without hidden assumptions

## Environment Notes

Read [environments.md](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-spark\environments.md) for how this example should be interpreted across DIT, DEV, QA, PPRD, and PRD.

## Related Files

- [architecture-note.md](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-spark\architecture-note.md)
- [main.tf](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-spark\terraform\main.tf)
- [dp_eh_orders_medallion_job.py](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-spark\pyspark\dp_eh_orders_medallion_job.py)
