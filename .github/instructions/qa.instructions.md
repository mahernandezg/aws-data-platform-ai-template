# QA Instructions

Use these instructions when generating or reviewing quality-assurance guidance, validation plans, test documentation, or QA-oriented assessments for this repository.

## Primary Objective

Produce QA outputs that strengthen release confidence, architecture compliance, and public-template quality.

QA in this repository is a governed validation function. It is not a generic testing label for every component and every environment.

## Mandatory Sources of Truth

Always align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`
- `docs/roles/*.md` when role alignment matters

## Opinionated Defaults

- Prefer explicit validation scope over broad checklist language.
- Prefer architecture-specific findings over generic quality comments.
- Prefer identifying control gaps and behavioural risks over superficial formatting feedback.
- Prefer reusable validation patterns that reinforce repository standards.
- Prefer crisp pass-fail reasoning over vague quality impressions.

## Mandatory Environment Rule

- QA applies to ISC, DP-EH, DCS, and DDC.
- QA does not apply to DP-SP in this repository.
- Do not write QA guidance that treats DP-SP as using a standalone QA environment.

## Mandatory Platform Standards

QA outputs must explicitly enforce:

- IAM Roles only
- no IAM Users
- Apache Iceberg as the standard Open Table Format from ISC onward
- Redshift serving-only positioning for final Data Products
- DDC as a Distribution layer, not a processing layer
- clear separation of ISC, DP-EH, DP-SP, DCS, and DDC responsibilities

## What Strong QA Looks Like Here

Strong QA guidance in this repository should check:

- architecture boundary compliance
- environment correctness
- Data Quality expectations
- Metadata and Data Lineage continuity
- governance and access-control behaviour
- Observability readiness
- consistency with public-safe repository standards

## Review Priorities

When reviewing a pipeline, document, prompt, or template, prioritize:

- critical behavioural regressions
- violations of mandatory standards
- ambiguous ownership or environment usage
- gaps in validation scope
- governance or observability weaknesses

Report findings in severity order when performing reviews.

## Prohibited Patterns

Do not:

- assign QA to DP-SP
- describe IAM Users as valid runtime identities
- accept non-Iceberg default outputs from ISC onward
- accept Redshift-centered processing designs
- reduce QA to formatting review when architecture or control issues exist
- introduce enterprise-confidential validation processes into the public repository
