# Redshift Loading Pattern - Ingestion S3 to Redshift Spark

## Purpose

This note explains the incremental loading pattern used to move the final Gold-ready output from Spark into Amazon Redshift.

## Chosen Pattern

This example uses:

- controlled S3 staging for the current serving increment
- `COPY` into a Redshift staging table
- `MERGE` from the staging table into the final Gold serving table

## Why This Pattern Fits the Architecture

This pattern fits the repository architecture because:

- processing remains in DP-EH with Spark
- Apache Iceberg remains the standard table model from ISC onward
- Redshift is used only to store and serve the final Gold Data Product in DDC
- incremental loading avoids unnecessary full refresh behavior

## Logical Sequence

1. Spark reconciles the current batch with the existing Iceberg Gold snapshot for affected business keys.
2. Spark writes the resulting serving increment to a controlled S3 prefix.
3. DDC loads that increment into a Redshift staging table by using `COPY`.
4. DDC merges the staged rows into the final Gold serving table.
5. Optional serving views or materialized views are refreshed if needed.

## Staging Table Pattern

The staging table should mirror the serving table closely enough to support deterministic merging.

Typical design intent:

- one load batch identifier for traceability
- business keys needed for merge logic and reconciliation
- payload columns needed by the serving table
- audit columns such as load timestamp

## Merge and Upsert Guidance

Use `MERGE` or an equivalent staging-table upsert pattern when:

- the Gold Data Product is updated incrementally
- business keys can identify changed records
- downstream consumers expect stable serving objects

For additive metrics such as counts and totals, the merge logic should update the final serving row with reconciled values for the affected business keys rather than overwrite long-lived totals with a single batch's partial aggregate.

Append-only loading is acceptable only when the Gold Data Product is naturally append-only and that behavior is explicitly justified.

## COPY Guidance

`COPY` should read from a controlled S3 staging location and use an IAM Role, not static credentials.

The load path should be:

- environment-aware
- batch-aware
- governed and observable

## Serving Objects

This example assumes:

- one staging table for the current batch
- one final Gold serving table
- optional serving views or materialized views for query convenience

This keeps Redshift focused on serving and consumer access rather than Transformation ownership.
