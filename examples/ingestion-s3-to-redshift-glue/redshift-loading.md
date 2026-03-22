# Redshift Loading Pattern - Ingestion S3 to Redshift Glue

## Purpose

This note explains the incremental loading pattern used to move the final Gold-ready output from Glue into Amazon Redshift.

## Chosen Pattern

This example uses:

- controlled S3 staging for the current serving increment
- `COPY` into a Redshift staging table
- `MERGE` from the staging table into the final Gold serving table

## Why This Pattern Fits the Architecture

This pattern fits the repository architecture because:

- processing remains in DP-EH with Glue
- Apache Iceberg remains the standard table model from ISC onward
- Redshift is used only to store and serve the final Gold Data Product in DDC
- incremental loading avoids unnecessary full refresh behavior

## Logical Sequence

1. Glue reconciles the current batch with the existing Iceberg Gold snapshot for affected business keys.
2. Glue writes the resulting serving increment to a controlled S3 prefix for serving ingestion.
3. DDC loads that increment into a Redshift staging table by using `COPY`.
4. DDC merges the staged rows into the final Gold serving table.

## Merge and Upsert Guidance

Use `MERGE` or an equivalent staging-table upsert pattern when:

- the Gold Data Product is updated incrementally
- business keys can identify changed records
- downstream consumers expect stable serving objects

For additive metrics such as counts and totals, the merge logic should update the final serving row with reconciled values for the affected business keys rather than overwrite long-lived totals with a single batch's partial aggregate.
