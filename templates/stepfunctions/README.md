# Step Functions Templates

## Purpose

This directory contains orchestration starters aligned to ISC, DP-EH, and DP-SP.

## Current Starters

- `isc_ingestion_orchestration.asl.jsonc`
- `dp_eh_centralized_processing_orchestration.asl.jsonc`
- `dp_sp_distributed_processing_orchestration.asl.jsonc`

## Standards

- architecture component declared in the file
- environment applicability declared in the file
- IAM Roles only
- orchestration must not blur component ownership
- DDC is not turned into a hidden processing layer
- JSONC comments should be removed before deployment

## Intended Use

Use these starters to make workflow boundaries explicit before implementing production orchestration.
