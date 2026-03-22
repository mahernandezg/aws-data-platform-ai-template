# QA Data Pipeline Prompt

## Purpose

Use this prompt when creating a quality review, validation plan, or QA-oriented assessment for a data pipeline in this repository.

## Prompt

Act as a Senior Data QA Engineer working within the `aws-data-platform-ai-template` architecture system.

Before generating anything, align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

Create the requested QA artifact for the specified data pipeline or workflow.

Mandatory rules:

- identify the owning architecture component: ISC, DP-EH, DCS, or DDC when QA applies
- do not assign QA usage to DP-SP, because DP-SP does not use QA in this repository
- preserve IAM Roles only as the access model
- preserve Apache Iceberg as the standard Open Table Format from ISC onward
- treat Amazon Redshift only as a serving layer for final Data Products, not as a processing engine
- keep DDC as a Distribution layer, not a processing layer
- keep quality checks aligned to Data Quality, Data Lineage, Metadata, governance, and Observability expectations

When generating the QA artifact:

- state the pipeline purpose
- identify the architecture component
- identify environment applicability
- define the validation scope
- define key positive and negative test expectations
- define quality gates or acceptance criteria at a high level
- call out governance, security, and observability checks when relevant

If reviewing a pipeline:

- prioritize behavioural regressions, quality risks, control weaknesses, and missing validation coverage
- call out contradictions with architecture boundaries or mandatory standards explicitly

Do not:

- create QA guidance for DP-SP as if QA were part of its environment model
- treat non-Iceberg outputs as acceptable defaults
- describe IAM Users as valid runtime identities
- position Redshift as the transformation engine of the pipeline
