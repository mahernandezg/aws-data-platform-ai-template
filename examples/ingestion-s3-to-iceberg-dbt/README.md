# Ingestion S3 to Iceberg dbt Example

This example is a compact end-to-end reference for a public AWS Data Platform implementation pattern built from the repository architecture system.

It demonstrates:

- ISC ingestion into an S3 Landing Zone
- DP-EH Medallion processing with Apache Iceberg
- dbt-based processing handoff for Bronze, Silver, and Gold modeling
- DDC Gold exposure through Amazon Athena
- IAM role-only assumptions from end to end

## Purpose

This example is intended to be a dbt-oriented companion to the Glue-based and Spark-based ingestion-to-Iceberg examples.

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
examples/ingestion-s3-to-iceberg-dbt/
|-- README.md
|-- architecture-note.md
|-- environments.md
|-- terraform/
|   |-- main.tf
|   |-- variables.tf
|   `-- outputs.tf
`-- dbt/
    |-- dbt_project.yml
    `-- models/
        |-- staging/
        |   |-- _sources.yml
        |   `-- stg_orders_landing.sql
        |-- intermediate/
        |   `-- int_orders_silver.sql
        `-- curated/
            `-- cur_orders_gold.sql
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
- one IAM role-only runtime pattern for a DP-EH dbt execution context

The example assumes AWS IAM Roles only. It does not create IAM Users.

## What the dbt Starter Does

The dbt starter models a simple Medallion progression in DP-EH:

1. a staging model reads Bronze-style landing data
2. an intermediate model represents Silver transformation logic
3. a curated model represents the Gold Data Product exposed by DDC through Athena

This keeps the example compact while still making the Medallion progression explicit.

## Example Teaching Value

This example is designed to be:

- easy to explain to a new engineer
- reusable as a first dbt-based accelerator pattern
- aligned to the repository architecture without hidden assumptions

## Environment Notes

Read [environments.md](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-dbt\environments.md) for how this example should be interpreted across DIT, DEV, QA, PPRD, and PRD.

## Related Files

- [architecture-note.md](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-dbt\architecture-note.md)
- [main.tf](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-dbt\terraform\main.tf)
- [dbt_project.yml](c:\Users\maher\OneDrive\Documentos\06_GitHub\aws-data-platform-ai-template\examples\ingestion-s3-to-iceberg-dbt\dbt\dbt_project.yml)
