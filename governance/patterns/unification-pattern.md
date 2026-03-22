# Unification Pattern

## Purpose

This pattern defines how shared enterprise unification should be handled.

## Architecture Alignment

- primary owner: `DP-EH`
- supporting control layer: `DCS`
- consumer exposure: `DDC`

## Pattern Summary

1. Bronze datasets are standardized in `DP-EH`.
2. Shared business rules and cross-domain harmonization are applied in Silver.
3. Enterprise-grade Gold outputs are produced in `DP-EH`.
4. `DDC` exposes those Gold outputs for governed consumption.

## Responsibilities

- `DP-EH` owns enterprise unification logic.
- `DP-SP` may consume or enhance results, but does not become the canonical enterprise unification owner.
- `DDC` serves unified Gold assets but does not process them.

## Typical Use Cases

- conformed business entities
- shared semantic layers
- shared enterprise dimensions
- cross-domain reconciliation

## Mandatory Rules

- Apache Iceberg remains the standard across Bronze, Silver, and Gold
- Redshift is not the main unification engine
- enterprise canonical Gold remains in `DP-EH`
