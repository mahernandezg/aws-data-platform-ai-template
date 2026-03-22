# Lineage Pattern

## Purpose

This pattern defines how lineage should be preserved across the platform.

## Architecture Alignment

- cross-cutting support: `DCS`
- applies to: `ISC`, `DP-EH`, `DP-SP`, `DDC`

## Pattern Summary

1. Ingestion origin is captured in ISC.
2. Bronze, Silver, and Gold transformations retain traceability.
3. Distribution preserves the link between producer-side assets and consumer-facing assets.

## Mandatory Rules

- lineage must remain visible across Landing Zone, Bronze, Silver, Gold, and DDC exposure
- batch, source, and load identifiers should remain traceable where relevant
- lineage is a platform concern, not an optional afterthought
