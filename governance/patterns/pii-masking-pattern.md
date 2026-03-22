# PII Masking Pattern

## Purpose

This pattern defines how personally identifiable information should be protected in the repository architecture.

## Architecture Alignment

- control owner: `DCS`
- processing owner: `DP-EH` or `DP-SP`
- serving owner: `DDC`

## Pattern Summary

1. Sensitive fields are identified through governance and Metadata controls.
2. Masking, tokenization, or access restriction is applied before broad downstream exposure.
3. Gold-serving outputs expose only the level of sensitivity appropriate for the intended audience.

## Responsibilities

- `DCS` owns governance controls and policy support
- processing layers apply architecture-aligned masking logic where needed
- `DDC` must not expose sensitive data outside governed access patterns

## Mandatory Rules

- role-based access only
- no informal exposure of raw sensitive fields
- public examples must remain generic and must not normalize unsafe handling of sensitive data
