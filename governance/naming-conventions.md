# Naming Conventions

## Purpose

This document defines the naming conventions used across the `aws-data-platform-ai-template` repository.

Its purpose is to keep architecture artifacts, templates, examples, configuration files, and generated outputs consistent, predictable, and easy to review.

## Naming Principles

- Names must reflect architecture responsibility.
- Names must stay aligned to the glossary and component model.
- Names must be readable by humans before they are optimized for tooling.
- Names must stay generic and public-safe.
- Names must not encode confidential enterprise context.

## Architecture Component Names

Use these component identifiers consistently:

- `ISC`
- `DP-EH`
- `DP-SP`
- `DCS`
- `DDC`

For lowercase machine-readable identifiers, use:

- `isc`
- `dp_eh` or `dp-eh` depending on file or tool constraints
- `dp_sp` or `dp-sp` depending on file or tool constraints
- `dcs`
- `ddc`

Do not invent alternate component labels such as:

- enterprise-zone
- spoke-zone
- central-hub
- distribution-hub

## Environment Names

Use these environment identifiers consistently:

- `DIT`
- `DEV`
- `QA`
- `PPRD`
- `PRD`

Lowercase machine-readable forms:

- `dit`
- `dev`
- `qa`
- `pprd`
- `prd`

Do not invent alternate environment names such as:

- test
- stage
- prodlike
- sandbox2

## Medallion Layer Names

Use these names exactly:

- `Landing Zone`
- `Bronze`
- `Silver`
- `Gold`

Lowercase machine-readable forms:

- `landing_zone`
- `bronze`
- `silver`
- `gold`

Do not replace them with vague terms such as:

- rawplus
- refined
- finalized
- curatedplus

## File Naming

### Markdown files

Use lowercase kebab-case for markdown file names unless the repository already uses another established pattern.

Examples:

- `hub-spoke-overview.md`
- `architecture-principles.md`
- `platform-standards.md`

### Python files

Use lowercase snake_case.

Examples:

- `isc_s3_ingestion_job.py`
- `dp_eh_orders_redshift_serving_job.py`

### Terraform resources and modules

Use clear lowercase identifiers that reflect purpose and ownership.

Examples:

- `dp_eh_spark_runtime_role`
- `ddc_redshift_copy_role`
- `platform_warehouse`

### YAML configuration files

Use lowercase kebab-case file names and lowercase snake_case keys where possible.

Examples:

- `environments.yaml`
- `platform-zones.yaml`
- `service-catalog.yaml`

## Resource Naming

When naming cloud resources or placeholders:

- include project or platform prefix
- include environment where relevant
- include component or responsibility where relevant
- avoid hidden abbreviations unless they are already standardized in the repo

Good examples:

- `adp-dev-s3-redshift-spark-isc-landing`
- `adp-dev-s3-redshift-glue-ddc-gold`
- `dp-eh-spark-runtime`

Bad examples:

- `bucket1`
- `gold-final-v2`
- `shared-prod-temp`

## Documentation Naming

Section titles and document labels should prefer the controlled vocabulary already defined in the repository.

Prefer:

- `Data Product`
- `Data Governance`
- `Observability`
- `Control Plane`
- `Distribution`

Do not mix equivalent-looking alternatives without reason.

## Prompt and Instruction Naming

Prompt and instruction files should clearly encode the artifact family or task family they govern.

Examples:

- `design-hub-spoke.prompt.md`
- `create-glue-job.prompt.md`
- `terraform.instructions.md`

## Naming Review Rule

A naming choice is acceptable only if:

- it matches repository vocabulary
- it reflects architecture ownership clearly
- it avoids ambiguity
- it remains readable to engineers and architects

If a new name introduces confusion, rename it before merging the change.
