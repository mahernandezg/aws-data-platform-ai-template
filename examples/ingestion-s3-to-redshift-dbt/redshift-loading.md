# Redshift Loading Pattern - Ingestion S3 to Redshift dbt

## Purpose

This note explains the incremental loading pattern used to move the final Gold-ready output from dbt into Amazon Redshift.

## Chosen Pattern

This example uses:

- controlled S3 staging for the current serving increment
- `COPY` into a Redshift staging table
- `MERGE` from the staging table into the final Gold serving table

## Why This Pattern Fits the Architecture

This pattern fits the repository architecture because:

- processing remains in DP-EH with dbt
- Apache Iceberg remains the standard table model from ISC onward
- Redshift is used only to store and serve the final Gold Data Product in DDC
- incremental loading avoids unnecessary full refresh behavior

## Logical Sequence

1. dbt produces the current Gold-serving increment in DP-EH.
2. That serving increment is written to a controlled S3 prefix for serving ingestion.
3. DDC loads that increment into a Redshift staging table by using `COPY`.
4. DDC merges the staged rows into the final Gold serving table.

## Merge and Upsert Guidance

Use `MERGE` when:

- the Gold Data Product is updated incrementally
- business keys can identify changed rows
- consumers expect stable serving objects

For additive metrics such as counts and totals, the merge logic should update the final serving row with reconciled values for the affected business keys rather than overwrite long-lived totals with a single batch's partial aggregate.

Append-only loading is acceptable only when the Gold Data Product is naturally append-only and that behavior is explicitly justified.
