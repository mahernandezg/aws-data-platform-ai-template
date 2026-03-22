# Governance Patterns

## Purpose

This directory documents repeatable architecture patterns used by the `aws-data-platform-ai-template` repository.

Its purpose is to provide a practical bridge between:

- architecture principles
- platform standards
- service mapping
- templates and examples
- future framework behavior

These patterns are not implementation runbooks. They are reusable architecture guidance for common data-platform situations.

## Pattern Set

- `ingestion-pattern.md`
- `unification-pattern.md`
- `cdc-merge-pattern.md`
- `gold-serving-to-redshift-pattern.md`
- `athena-serving-pattern.md`
- `pii-masking-pattern.md`
- `lineage-pattern.md`
- `dq-validation-pattern.md`
- `dp-eh-enterprise-gold-pattern.md`
- `dp-sp-domain-gold-enhancement-pattern.md`

## Repository Rules

All patterns in this directory must preserve:

- IAM Roles only
- Apache Iceberg from ISC onward
- Redshift serving only
- Medallion ownership boundaries
- Hub-and-Spoke component boundaries
- multi-account and multi-region rules
- public-safe and generic documentation
