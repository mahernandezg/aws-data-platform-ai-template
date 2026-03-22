# Athena Serving Pattern

## Purpose

This pattern defines the serverless Gold-serving pattern through Athena.

## Architecture Alignment

- processing owner: `DP-EH` or constrained `DP-SP`
- serving owner: `DDC`

## Pattern Summary

1. Gold data is produced in Apache Iceberg.
2. Gold datasets remain on S3 with Iceberg table semantics.
3. `DDC` exposes those Gold datasets through Athena for serverless consumption.

## Good Fit

- serverless BI and analytics
- lower operational overhead
- consumption patterns that do not justify Redshift

## Mandatory Rules

- Apache Iceberg remains mandatory
- DDC exposes Gold only by default
- Athena does not turn DDC into a processing layer
