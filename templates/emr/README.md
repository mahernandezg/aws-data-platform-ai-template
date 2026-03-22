# EMR Templates

## Purpose

This directory contains Amazon EMR scaffolds aligned to the repository architecture.

## Architecture Alignment

- primary fit: `DP-EH`
- conditional fit: `DP-SP`
- not a serving pattern
- not a replacement for `DDC`

## Current Starter

- `emr_serverless_processing.tf`

## Standards

- IAM Roles only
- Apache Iceberg from ISC onward
- EMR is used for processing, not final consumer serving
- explicit architecture ownership
- explicit environment applicability
- explicit lineage and observability extension points

## Intended Use

Use these starters when Spark-based processing needs more runtime control or scale flexibility than the lighter Glue-based path.

Do not use these starters to position EMR as a consumer-serving layer or as a workaround around Medallion ownership boundaries.
