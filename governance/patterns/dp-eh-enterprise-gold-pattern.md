# DP-EH Enterprise Gold Pattern

## Purpose

This pattern defines the enterprise canonical Gold pattern owned by DP-EH.

## Architecture Alignment

- owner: `DP-EH`
- exposure: `DDC`

## Pattern Summary

1. Shared Bronze and Silver processing is completed in `DP-EH`.
2. Enterprise business rules and shared semantic structures are applied.
3. Gold outputs are modeled as enterprise Data Products.
4. `DDC` exposes those Gold outputs for consumption.

## Typical Characteristics

- star-schema structures
- dimension and fact tables
- shared enterprise semantics
- SCD Type 2 where appropriate

## Mandatory Rules

- enterprise canonical Gold belongs in `DP-EH`
- Redshift may serve the result, but does not become the transformation owner
- DDC exposes the result, but does not own Gold processing
