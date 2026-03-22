# Architecture Note - Ingestion S3 to Iceberg Spark

## Purpose

This note explains how the `ingestion-s3-to-iceberg-spark` example aligns to the repository architecture system.

## Architecture Components

The example uses:

- ISC for raw source entry into the Landing Zone
- DP-EH for Bronze, Silver, and Gold processing
- DCS for IAM role-based runtime control and shared governance assumptions
- DDC for Gold Data Product exposure through Athena

The example does not use DP-SP because it is intentionally focused on the enterprise baseline pattern.

## End-to-End Flow

1. ISC lands the input file into an S3 Landing Zone path.
2. A DP-EH Spark job reads the Landing Zone file.
3. DP-EH writes a Bronze Iceberg table.
4. DP-EH derives a Silver Iceberg table.
5. DP-EH derives a Gold Iceberg table.
6. DDC exposes the Gold table through Athena for governed downstream access.

## Medallion Responsibilities

- ISC owns the Landing Zone only.
- DP-EH owns the Bronze, Silver, and Gold layers in this example.
- DDC exposes Gold only.

This example does not permit default consumer access to Bronze or Silver.

## IAM and Access Model

The example assumes:

- IAM Roles only
- no IAM Users
- least-privilege runtime access for Spark and Athena
- shared governance handled through DCS-aligned controls

## Iceberg Standard

From the first managed table onward, data is stored in Apache Iceberg.

The Landing Zone remains an ISC raw-entry concern. Bronze, Silver, and Gold remain Apache Iceberg-managed tables aligned to repository standards.

## DDC Exposure Rule

DDC is used only for Gold exposure in this example.

Athena queries should target the Gold table. Bronze and Silver remain internal processing layers for this pattern.

## What This Example Does Not Show

This example does not attempt to show:

- DP-SP domain-specific processing
- Redshift serving patterns
- AI-oriented access exceptions to Bronze or Silver
- multi-domain orchestration complexity

The goal is to provide a first memorable Spark-based accelerator example, not a complete enterprise deployment.
