# DQ Validation Pattern

## Purpose

This pattern defines how data quality validation should be applied across the platform lifecycle.

## Architecture Alignment

- applies across all components
- quality governance supported by `DCS`
- validation intensity depends on environment and component

## Pattern Summary

1. Ingestion quality checks occur at entry and landing boundaries.
2. Bronze and Silver validation confirms structure and transformation correctness.
3. Gold validation confirms Data Product fitness for downstream use.
4. Environment-specific validation intensity increases from DIT to PRD.

## Responsibilities

- `ISC` validates ingestion correctness
- `DP-EH` and `DP-SP` validate transformation correctness
- `DDC` validates serving correctness and exposure quality

## Mandatory Rules

- data quality must be explicit
- QA does not apply to DP-SP, so spoke validation must be designed across DEV, PPRD, and PRD accordingly
- quality checks must not contradict Medallion ownership
