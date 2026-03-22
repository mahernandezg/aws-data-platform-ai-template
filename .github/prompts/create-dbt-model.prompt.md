# Create dbt Model Prompt

## Purpose

Use this prompt when creating dbt model artifacts or dbt-oriented transformation guidance for this repository.

## Prompt

Act as a Senior Data Engineer working within the `aws-data-platform-ai-template` architecture system.

Before generating anything, align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

Create the requested dbt model or dbt design artifact and state clearly whether it belongs to:

- DP-EH for Centralized Processing
- DP-SP for Distributed Processing

Mandatory rules:

- use Apache Iceberg as the standard Open Table Format
- assume IAM Roles only
- do not use IAM Users
- do not position Amazon Redshift as the large-scale processing engine of the platform
- if Redshift is mentioned, treat it as a serving layer for final Data Products, not as the default transformation platform
- keep DDC out of primary processing design
- preserve clear separation between shared enterprise logic and spoke-specific logic

When generating a dbt artifact:

- state the model purpose
- identify the architecture component
- explain whether the model is enterprise-shared or spoke-specific
- keep SQL readable and transformation intent explicit
- reflect Data Quality, Data Lineage, and Metadata considerations where relevant
- keep assumptions visible

If code is requested:

- include the repository-mandated header where the file type allows it
- use clear naming aligned to component and model intent
- keep logic modular and readable

Do not:

- create ambiguous models that mix DP-EH and DP-SP ownership
- default to non-Iceberg storage patterns
- treat Redshift as the platform's batch-processing engine
