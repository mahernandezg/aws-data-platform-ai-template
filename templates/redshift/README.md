# Redshift Templates

## Purpose

This directory contains Amazon Redshift serving scaffolds aligned to the repository architecture.

## Architecture Alignment

- primary serving owner: `DDC`
- producer-side structures in `DP-EH` or `DP-SP` are allowed only within the repository's producer-cluster boundary
- Redshift is serving only, not the main processing engine

## Current Starters

- `redshift_cluster_serving.tf`
- `redshift_serverless_serving.tf`
- `database.sql`
- `schema.sql`
- `gold_serving_table.sql`
- `gold_serving_view.sql`
- `gold_serving_materialized_view.sql`
- `column_anonymization_view.sql`

## Standards

- IAM Roles only
- Redshift serving only
- final consumer-serving layer belongs in `DDC`
- Gold-only normal consumer exposure
- no hidden transformation ownership in Redshift
- explicit comments for lineage, auditability, and observability extension points

## Intended Use

Use these starters to scaffold Redshift-serving assets after Gold-ready data already exists outside Redshift.
