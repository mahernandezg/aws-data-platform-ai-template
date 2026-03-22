# Ingestion Pattern

## Purpose

This pattern defines the standard governed ingestion path into the platform.

## Architecture Alignment

- component owner: `ISC`
- downstream handoff: `DP-EH` or `DP-SP`
- control support: `DCS`

## Pattern Summary

1. Source data enters the platform through `ISC`.
2. `ISC` lands data in a governed Landing Zone.
3. Ingestion Metadata, traceability, and controls are captured.
4. Data is handed off for Bronze standardization in `DP-EH` or `DP-SP`.

## Responsibilities

- `ISC` owns source entry, landing, and ingestion controls.
- `DCS` supports IAM, governance, Metadata, and Observability.
- `ISC` does not own Bronze, Silver, or Gold processing.

## Mandatory Rules

- IAM Roles only
- Apache Iceberg mandatory from ISC onward
- Landing Zone owned by ISC only
- no consumer-facing serving in ISC

## Typical Service Fit

- Amazon S3
- AWS Glue
- AWS Glue Crawler
- AWS Glue API
- Amazon EventBridge
- Amazon SQS
- AWS Lambda
- AWS Step Functions

## Boundaries

- do not treat ISC as a transformation layer
- do not treat ISC as a distribution layer
- do not bypass DCS governance controls
