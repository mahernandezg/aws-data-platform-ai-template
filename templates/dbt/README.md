# dbt Templates

## Purpose

This directory contains dbt starters aligned to the repository Medallion model.

## Current Starters

- `dbt_project.yml`
- `models/staging`
- `models/intermediate`
- `models/curated`

## Standards

- dbt belongs in DP-EH or DP-SP, not DDC
- staging, intermediate, and curated responsibilities remain distinct
- Apache Iceberg remains the standard from ISC onward
- lineage and transformation intent stay readable in SQL
- comments should preserve architecture clarity

## Intended Use

Use these starters to scaffold Bronze-aligned, Silver-aligned, and Gold-aligned modeling while keeping ownership boundaries explicit.
