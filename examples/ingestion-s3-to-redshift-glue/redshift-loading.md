# Redshift Loading Pattern - Ingestion S3 to Redshift Glue

## Purpose

This note explains the incremental loading pattern used to move the final Gold-ready output from Glue into Amazon Redshift.

## Chosen Pattern

This example uses:

- controlled S3 staging for the current Gold-ready batch
- `COPY` into a Redshift staging table
- `MERGE` from the staging table into the final Gold serving table

## Why This Pattern Fits the Architecture

This pattern fits the repository architecture because:

- processing remains in DP-EH with Glue
- Apache Iceberg remains the standard table model from ISC onward
- Redshift is used only to store and serve the final Gold Data Product in DDC
- incremental loading avoids unnecessary full refresh behavior

## Logical Sequence

1. Glue produces the current Gold-ready output in DP-EH.
2. That output is written to a controlled S3 prefix for serving ingestion.
3. DDC loads that increment into a Redshift staging table by using `COPY`.
4. DDC merges the staged rows into the final Gold serving table.
