# Ingestion S3 to Redshift Glue Example

This example is a compact end-to-end reference for a public AWS Data Platform implementation pattern built from the repository architecture system.

It demonstrates:

- ISC ingestion into an S3 Landing Zone
- DP-EH Medallion processing with Apache Iceberg
- Glue-based processing handoff through a single AWS Glue job
- DDC Gold serving through Amazon Redshift
- IAM role-only assumptions from end to end

## Purpose

This example is intended to be the Redshift-serving companion to the Iceberg-and-Athena Glue example.

It preserves the repository's non-negotiable standards:

- IAM Roles only
- Apache Iceberg from ISC onward
- Medallion layer ownership from Landing Zone through Gold
- Redshift used only to store and serve the final Gold Data Product
- processing kept outside Redshift

## Architecture Alignment

This example covers the following component path:

- ISC for Landing Zone ingestion
- DP-EH for Bronze, Silver, and enterprise Gold processing
- DDC for final Gold serving in Redshift
- DCS for IAM role-based access and shared governance assumptions

It does not use DP-SP because the goal is to teach the enterprise baseline pattern with minimal spoke-specific variation.

## Source-to-Target Flow

1. ISC lands the source file into an S3 Landing Zone path.
2. A DP-EH Glue job reads the Landing Zone file.
3. DP-EH writes Bronze, Silver, and Gold Apache Iceberg tables.
4. DP-EH writes the current Gold-serving batch into a controlled S3 staging path for Redshift loading.
5. DDC loads that staged batch into Redshift by using a staging-table pattern with `COPY` and `MERGE`.
6. DDC exposes the final Gold serving table, plus optional serving views or materialized views, to downstream consumers.

## Why Redshift Is Used Here

Redshift is used here as a serving layer for the final Gold Data Product when:

- consumers need high-performance structured access
- BI-oriented workloads justify a dedicated serving layer
- read optimization is more important than serverless flexibility

This aligns with the repository rule that DDC may use Redshift as a consumer-serving pattern.

## Why Redshift Is Not the Processing Engine

This example keeps all Transformation logic in Glue and Apache Iceberg.

Redshift is not used to:

- perform Bronze processing
- perform Silver processing
- act as the main Gold transformation engine
- replace Glue as the enterprise processing layer

The Redshift table is populated only after the Gold-ready dataset has already been produced outside Redshift.

## Incremental Load Strategy

This example uses a realistic enterprise pattern:

- Glue writes the current Gold-ready batch to a controlled S3 staging path
- DDC loads that batch into a Redshift staging table with `COPY`
- DDC merges staged rows into the final Gold serving table by business key

Read [redshift-loading.md](/c:/Users/maher/OneDrive/Documentos/06_GitHub/aws-data-platform-ai-template/examples/ingestion-s3-to-redshift-glue/redshift-loading.md) for the detailed loading pattern.

## Expected Redshift Objects

This example assumes the following Redshift serving objects in DDC:

- one database for the consumer-serving domain
- one schema for the example Data Product
- one staging table loaded by `COPY`
- one final Gold serving table
- optional views or materialized views for consumer-friendly access

## Folder Structure

```text
examples/ingestion-s3-to-redshift-glue/
|-- README.md
|-- architecture.md
|-- environments.md
|-- redshift-loading.md
|-- terraform/
|   |-- main.tf
|   |-- variables.tf
|   `-- outputs.tf
`-- glue/
    `-- dp_eh_orders_redshift_serving_job.py
```

## Environment Notes

Read [environments.md](/c:/Users/maher/OneDrive/Documentos/06_GitHub/aws-data-platform-ai-template/examples/ingestion-s3-to-redshift-glue/environments.md) for how this example should be interpreted across DIT, DEV, QA, PPRD, and PRD.

## IAM Roles Only Reminder

This example assumes:

- IAM Roles only
- no IAM Users
- role-based Glue runtime access
- role-based Redshift loading access

## Apache Iceberg Consistency Reminder

Apache Iceberg remains the standard Open Table Format from ISC onward in this example:

- Landing Zone input enters through ISC
- Bronze, Silver, and enterprise Gold are written as Iceberg tables in DP-EH
- Redshift stores only the final serving copy of the Gold Data Product in DDC

The introduction of Redshift does not remove Apache Iceberg from the platform story.
