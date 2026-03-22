# Architecture - Ingestion S3 to Redshift Spark

## Purpose

This note explains how the `ingestion-s3-to-redshift-spark` example aligns to the repository architecture system.

## Component Mapping

The example uses:

- ISC for raw source entry into the Landing Zone
- DP-EH for Bronze, Silver, and enterprise Gold processing in Apache Iceberg
- DCS for IAM role-based runtime control and shared governance assumptions
- DDC for final Gold serving in Amazon Redshift

The example does not use DP-SP because it is intentionally focused on the enterprise baseline pattern.

## Data Flow

1. ISC lands the input file into an S3 Landing Zone path.
2. A DP-EH Spark job reads the Landing Zone file.
3. DP-EH writes a Bronze Iceberg table.
4. DP-EH derives a Silver Iceberg table.
5. DP-EH derives an enterprise Gold Iceberg table.
6. DP-EH writes the current Gold-serving increment to a controlled S3 staging path.
7. DDC loads the staged increment into a Redshift staging table by using `COPY`.
8. DDC merges the staged rows into the final Redshift Gold serving table.

## Processing Layer vs Serving Layer Separation

This example keeps processing and serving explicitly separate.

Processing layer:

- Landing Zone in ISC
- Bronze, Silver, and enterprise Gold processing in DP-EH
- Apache Iceberg as the standard table format from ISC onward

Serving layer:

- Redshift in DDC for the final Gold serving copy
- optional serving views or materialized views in DDC

Redshift is not used here as a Medallion processing engine. It is only the final consumer-serving layer.

## Redshift Role in the Example

Redshift is used in DDC because this example assumes a Gold Data Product that benefits from:

- high-performance structured query access
- BI-oriented consumption
- serving-side table and view optimization

That role is intentionally narrower than DP-EH processing. Redshift receives Gold-ready data after Spark processing has already completed.

## Incremental Load Design Notes

This example uses a controlled incremental load pattern:

- Spark produces the current Gold-ready batch outside Redshift
- the batch is staged in S3 under a controlled Redshift load prefix
- Redshift loads that batch into a staging table by using `COPY`
- Redshift merges staged rows into the final target table by business key

This pattern fits Gold Data Products because:

- it preserves Spark as the Transformation engine
- it preserves Apache Iceberg as the standard table format during processing
- it gives DDC a serving-optimized table in Redshift
- it supports repeatable incremental refresh instead of full reloads by default

## What This Example Does Not Show

This example does not attempt to show:

- DP-SP domain-specific processing
- Redshift as a processing engine
- AI-oriented access exceptions to Bronze or Silver
- multi-domain orchestration complexity
- a production-hardened Redshift deployment topology

The goal is to provide a first memorable Spark-based Redshift-serving accelerator example, not a complete enterprise deployment.
