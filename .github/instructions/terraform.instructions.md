# Terraform Instructions

Use these instructions when generating or reviewing Terraform code, modules, examples, or infrastructure guidance for this repository.

## Primary Objective

Produce Terraform that is architecture-aligned, reviewable, role-based, and safe for a public repository.

Do not use Terraform to smuggle in architecture decisions that contradict the documented platform model.

## Mandatory Sources of Truth

Always align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

## Opinionated Defaults

- Prefer clear, explicit Terraform over clever module indirection.
- Prefer readable resource naming over abstraction-heavy patterns.
- Prefer reusable modules only when they preserve architecture clarity.
- Prefer environment-aware inputs and outputs over hidden assumptions.
- Prefer DCS-governed access and control patterns over component-local reinvention.

## Mandatory Platform Standards

### IAM

- Use IAM Roles only.
- Do not generate IAM Users.
- Do not generate access-key-based user patterns as defaults.
- Assume runtime execution, automation, and operator access are role-based and assumable.

### Data Format

- Preserve Apache Iceberg as the standard Open Table Format from ISC onward.
- Do not provision default storage or metadata patterns that imply non-Iceberg tables as the platform baseline.

### Redshift

- Treat Amazon Redshift as a serving layer for final Data Products.
- Do not design Terraform that positions Redshift as the main engine for large-scale processing.
- Producer-side Redshift structures in DP-EH or DP-SP do not replace DDC.
- Consumer-facing Redshift serving belongs in DDC.

## Component Boundary Rules

- ISC Terraform should support Ingestion and controlled landing patterns.
- DP-EH Terraform should support Centralized Processing, not generic catch-all infrastructure.
- DP-SP Terraform should support domain-aligned processing without duplicating DCS responsibilities.
- DCS Terraform should own shared control capabilities such as IAM, Lake Formation-aligned governance, Secrets Manager, and Observability foundations.
- DDC Terraform should support Data Distribution and governed consumption, not primary processing.

## Environment Rules

- Use only the repository environment model: DIT, DEV, QA, PPRD, PRD.
- Do not invent additional environments in Terraform examples unless explicitly requested.
- Do not model QA for DP-SP because DP-SP does not use QA in this repository.

## Required Terraform Quality

When generating Terraform:

- include the mandatory repository header
- use variables for environment- and deployment-specific values
- keep resource intent obvious from names and comments
- avoid embedded secrets, tokens, passwords, or private endpoints
- expose only meaningful outputs
- keep tags and naming aligned with component and environment intent
- make least-privilege intent explicit where IAM is involved

## Review Priorities

When reviewing Terraform, prioritize:

- architecture fit
- IAM and access boundary correctness
- environment correctness
- DCS versus non-DCS responsibility separation
- public-safe configuration
- maintainability and reuse

## Prohibited Patterns

Do not:

- create IAM Users
- embed long-lived credentials
- treat Redshift as a transformation platform
- create DDC infrastructure that behaves like DP-EH or DP-SP
- create DP-SP QA patterns
- hardcode organization-specific account structures as if they were repository defaults
- add private company identifiers, internal URLs, or confidential standards
