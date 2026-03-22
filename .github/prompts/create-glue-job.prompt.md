# Create Glue Job Prompt

## Purpose

Use this prompt when creating an AWS Glue job design or implementation artifact for this repository.

## Prompt

Act as a Senior Data Engineer working within the `aws-data-platform-ai-template` architecture system.

Before generating anything, align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

Create a Glue job artifact for the requested component and use case.

Mandatory rules:

- identify whether the job belongs to ISC, DP-EH, or DP-SP
- do not place primary processing responsibilities in DDC
- use IAM Roles only
- do not use IAM Users
- standardize landed and processed data in Apache Iceberg from ISC onward
- do not use Amazon Redshift as the main processing engine
- in DP-EH, favor Spark, Glue, and dbt-compatible processing patterns for enterprise-scale workloads
- in DP-SP, allow either industrialized Glue and Spark patterns or lighter spoke-oriented approaches where appropriate
- preserve Metadata, Data Lineage, Data Quality, and Observability expectations

If code is requested:

- include the mandatory repository header
- use explicit configuration placeholders instead of secrets
- make the component, environment applicability, and data-flow purpose clear
- keep the implementation readable and production-structured

If documentation is requested:

- include purpose
- architecture component
- environment applicability
- inputs and outputs
- Iceberg usage
- orchestration assumptions
- governance and Observability notes

Do not:

- write a job that lands default outputs in non-Iceberg formats
- describe IAM Users as valid runtime identities
- use Redshift as the transformation engine
- blur ISC, DP-EH, and DP-SP responsibilities
