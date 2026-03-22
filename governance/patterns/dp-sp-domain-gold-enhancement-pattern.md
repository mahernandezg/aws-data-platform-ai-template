# DP-SP Domain Gold Enhancement Pattern

## Purpose

This pattern defines the constrained spoke Gold pattern where a domain enhances enterprise Gold or publishes a domain-specific Gold Data Product.

## Architecture Alignment

- owner: `DP-SP`
- upstream relationship: `DP-EH` and `DDC`
- exposure: `DDC`

## Pattern Summary

1. A spoke consumes approved upstream assets.
2. The spoke applies domain-specific transformation or enhancement logic.
3. The spoke produces a Gold output only when it remains domain-specific or explicitly enhances `DP-EH` Gold.
4. `DDC` exposes the resulting Gold asset under governed access.

## Mandatory Rules

- DP-SP must not redefine enterprise canonical Gold
- spoke Gold must remain bounded to domain-specific ownership
- DDC remains the exposure layer
- Apache Iceberg remains the standard
