# Architecture Instructions

Use these instructions when generating or reviewing architecture documentation, design notes, prompts, templates, or guidance in this repository.

## Primary Objective

Produce outputs that strengthen the repository as one coherent architecture system, not as disconnected documents.

## Mandatory Sources of Truth

Always align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`
- `docs/roles/*.md` when role alignment matters

If terminology or responsibility wording conflicts with those files, follow the glossary first, then the architecture overview, then the component documents.

## Mandatory Architecture Model

Use these component names exactly:

- ISC - Ingestion Service Center
- DP-EH - Data Processing Center - Enterprise Hub
- DP-SP - Data Processing Center - Spoke
- DCS - Data Core Services
- DDC - Data Distribution Center

Use these environment names exactly:

- DIT - Sandbox
- DEV - Development
- QA - Quality Assurance
- PPRD - Pre Production
- PRD - Production

DP-SP does not use QA. Do not describe QA as universally applicable across all components.

## Mandatory Platform Standards

These rules are non-negotiable:

- IAM uses IAM Roles only.
- IAM Users are not used in the platform.
- Apache Iceberg is the standard Open Table Format from ISC onward.
- Amazon Redshift is used only to store and serve final Data Products.
- Amazon Redshift is not a large-scale processing engine.
- DP-EH favors Spark, Glue, and dbt for enterprise-scale processing.
- DP-SP may use the same industrialized stack or lighter tools such as AWS Glue Studio and AWS Glue DataBrew.
- DDC supports both Redshift-based serving and S3 plus Apache Iceberg plus Athena serverless consumption.
- SageMaker Unified Studio may support ML and advanced analytics in DP-EH and DP-SP.
- SageMaker Unified Studio in DDC is limited to discovery and interaction, not processing.

## Boundary Rules

- Keep Ingestion, Centralized Processing, Distributed Processing, Control Plane responsibilities, and Data Distribution clearly separated.
- Do not blur hub responsibilities with spoke responsibilities.
- Do not assign DCS business-data processing ownership.
- Do not turn DDC into a processing layer.
- Do not turn DP-EH into a catch-all for every workload.
- Do not describe DP-SP as an exception path outside governance.

## Writing Rules

- Use glossary-aligned terminology consistently.
- Prefer precise architecture language over generic platform buzzwords.
- Make responsibilities explicit.
- State boundaries clearly.
- Reinforce mandatory standards where they matter, especially IAM, Iceberg, Redshift, and environment applicability.
- Keep the repository public and generic.
- Do not reference internal company details, confidential standards, or private operating models.

## When Producing Architecture Artifacts

Include, when relevant:

- purpose
- scope
- responsibilities
- boundaries
- inbound and outbound interactions
- Data Plane versus Control Plane responsibilities
- environment applicability
- governance and security implications
- Observability implications
- service-alignment rationale

## Prohibited Patterns

Do not:

- invent new architecture components
- rename existing components
- introduce conflicting definitions of hub and spoke behavior
- treat Redshift as the default transformation engine
- treat non-Iceberg tables as the default platform pattern
- describe IAM Users as valid access entities in the platform
- write architecture guidance that contradicts the environment model
