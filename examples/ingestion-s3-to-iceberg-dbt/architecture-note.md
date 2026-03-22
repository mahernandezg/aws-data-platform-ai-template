# Architecture Note - Ingestion S3 to Iceberg dbt

## Purpose

This note explains how the `ingestion-s3-to-iceberg-dbt` example aligns to the repository architecture system.

## Architecture Components

The example uses:

- ISC for raw source entry into the Landing Zone
- DP-EH for Bronze, Silver, and Gold processing
- DCS for IAM role-based runtime control and shared governance assumptions
- DDC for Gold Data Product exposure through Athena

The example does not use DP-SP because it is intentionally focused on the enterprise baseline pattern.

## End-to-End Flow

1. ISC lands the input file into an S3 Landing Zone path.
2. A DP-EH Bronze Iceberg table is made available for transformation.
3. dbt staging logic reads the Bronze-aligned source relation.
4. dbt intermediate logic derives a Silver-aligned model.
5. dbt curated logic derives a Gold Data Product model.
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
- least-privilege runtime access for dbt execution and Athena
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

The goal is to provide a first memorable dbt-based accelerator example, not a complete enterprise deployment.
