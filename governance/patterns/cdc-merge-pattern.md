# CDC / Merge Pattern

## Purpose

This pattern defines the standard approach for change-data-capture and merge-style updates.

## Architecture Alignment

- ingestion entry: `ISC`
- processing owner: `DP-EH` or `DP-SP`
- serving owner when needed: `DDC`

## Pattern Summary

1. Incremental source changes are ingested through `ISC`.
2. Bronze preserves traceability and batch or event context.
3. Silver applies merge or reconciliation logic.
4. Gold reflects the correct current or historized state depending on the Data Product design.

## Responsibilities

- merge logic belongs in processing layers, not in DDC as a hidden transformation layer
- DDC may merge staged serving data into Redshift only after Gold-ready logic is already complete outside Redshift

## Good Fit

- SCD Type 2 patterns
- upsert pipelines
- additive metric reconciliation
- stateful entity refresh

## Mandatory Rules

- do not overwrite long-lived totals with one batch’s partial aggregate
- keep lineage and batch traceability visible
- keep Redshift merge behavior limited to final serving updates
