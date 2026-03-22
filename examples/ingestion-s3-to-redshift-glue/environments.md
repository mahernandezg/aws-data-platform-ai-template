# Environment Notes - Ingestion S3 to Redshift Glue

## Purpose

These notes explain how the `ingestion-s3-to-redshift-glue` example should be interpreted across the repository environment model.

## DIT

Use DIT to validate:

- source file shape assumptions
- Landing Zone path conventions
- Glue runtime configuration
- initial Iceberg catalog behavior
- Redshift staging-path conventions

DIT should not be treated as the final reference for serving design or downstream access behavior.

## DEV

Use DEV to:

- refine the Glue job logic
- stabilize Bronze, Silver, and Gold Iceberg definitions
- validate the Gold-serving extract written for Redshift loading
- test the Redshift `COPY` plus `MERGE` pattern
- confirm IAM role assumptions

DEV is where the example becomes implementation-ready.

## QA

Use QA to validate:

- ISC ingestion correctness
- DP-EH Medallion progression
- DDC Gold serving behavior in Redshift
- governance, observability, and role-based load behavior

This example does not involve DP-SP, so the repository rule about DP-SP excluding QA does not create special handling here.

## PPRD

Use PPRD to confirm:

- production-like S3 path behavior
- production-like Iceberg table behavior
- production-like Redshift serving behavior
- incremental loading under realistic conditions
- IAM role and governance behavior under realistic conditions

## PRD

In PRD, this pattern should operate with:

- IAM Roles only
- Apache Iceberg tables for Bronze, Silver, and enterprise Gold in DP-EH
- Redshift serving of the final Gold Data Product in DDC
- no drift of Redshift into the main processing role

## Summary

The environment model does not change Medallion ownership in this example. Across all environments:

- ISC remains Landing Zone only
- DP-EH remains Bronze, Silver, and enterprise Gold owner
- DDC remains the final Gold serving layer in Redshift
