# Environment Notes - Ingestion S3 to Iceberg Spark

## Purpose

These notes explain how the `ingestion-s3-to-iceberg-spark` example should be interpreted across the repository environment model.

## DIT

Use DIT to validate:

- source file shape assumptions
- Landing Zone path conventions
- Spark runtime configuration
- initial Iceberg catalog behavior

DIT should not be treated as the final reference for table design or downstream access behavior.

## DEV

Use DEV to:

- refine the PySpark job logic
- stabilize Bronze, Silver, and Gold table definitions
- test IAM role assumptions
- validate Athena exposure of Gold

DEV is where the example becomes implementation-ready.

## QA

Use QA to validate:

- ISC ingestion correctness
- DP-EH Medallion progression
- DDC Gold exposure behavior
- governance and observability expectations

This example does not involve DP-SP, so the repository rule about DP-SP excluding QA does not create special handling here.

## PPRD

Use PPRD to confirm:

- production-like S3 path behavior
- production-like Iceberg table behavior
- Gold-only exposure through Athena
- IAM role and governance behavior under realistic conditions

## PRD

In PRD, this pattern should operate with:

- IAM Roles only
- Apache Iceberg tables for Bronze, Silver, and Gold
- DDC exposure of Gold only
- no drift of Bronze or Silver into default consumer access

## Summary

The environment model does not change Medallion ownership in this example. Across all environments:

- ISC remains Landing Zone only
- DP-EH remains Bronze, Silver, and Gold owner
- DDC remains Gold exposure only
