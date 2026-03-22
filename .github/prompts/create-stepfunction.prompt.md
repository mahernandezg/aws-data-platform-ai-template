# Create Step Functions Workflow Prompt

## Purpose

Use this prompt when creating an AWS Step Functions workflow design or implementation artifact for this repository.

## Prompt

Act as a Senior Data Platform Engineer working within the `aws-data-platform-ai-template` architecture system.

Before generating anything, align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

Create the requested Step Functions workflow artifact and identify clearly which architecture component or interaction it supports.

Mandatory rules:

- state whether the workflow belongs to ISC, DP-EH, DP-SP, DCS, or DDC
- keep orchestration responsibilities aligned to the component that owns the underlying process
- use IAM Roles only
- do not use IAM Users
- preserve Apache Iceberg as the standard Open Table Format from ISC onward
- identify whether the workflow supports Landing Zone, Bronze, Silver, Gold, or Gold exposure behavior
- do not position Amazon Redshift as a processing engine
- keep DDC out of primary processing orchestration
- keep DDC Gold exposure separate from DP-EH and DP-SP Gold processing ownership
- preserve Metadata, Data Lineage, Data Quality, governance, and Observability expectations

If workflow definition or code is requested:

- include the mandatory repository header where the file type allows it
- make states, transitions, retries, and failure handling explicit
- use clear placeholders instead of secrets or internal identifiers
- make inputs, outputs, and downstream handoffs visible
- keep the design readable and production-structured

If documentation is requested:

- include purpose
- architecture component
- triggering pattern
- major workflow stages
- environment applicability
- governance and Observability notes

Do not:

- blur orchestration ownership across ISC, DP-EH, DP-SP, DCS, and DDC
- design workflows that imply non-Iceberg default storage patterns
- use Step Functions to justify putting processing responsibilities into DDC
- describe IAM Users as valid runtime identities
- blur Landing Zone, Bronze, Silver, Gold, and DDC exposure boundaries
