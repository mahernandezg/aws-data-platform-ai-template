# dbt Instructions

Use these instructions when generating or reviewing dbt models, dbt project structure, SQL transformations, or dbt-oriented guidance for this repository.

## Primary Objective

Produce dbt artifacts that are explicit, layered, and architecture-aligned.

dbt in this repository should clarify transformation intent and ownership. It should not become a place where component boundaries disappear behind generic SQL.

## Mandatory Sources of Truth

Always align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

## Opinionated Defaults

- Prefer clear staging, intermediate, and final model separation when the workload justifies it.
- Prefer readable SQL over compact SQL.
- Prefer one clear ownership boundary per model.
- Prefer explicit assumptions and naming over generic model titles.
- Prefer durable business meaning over purely technical table reshaping.

## Mandatory Platform Standards

### Component Ownership

- dbt models belong in DP-EH or DP-SP.
- Use DP-EH for Centralized Processing and enterprise-shared logic.
- Use DP-SP for domain-aligned Distributed Processing.
- Do not assign primary dbt transformation ownership to DDC.
- Use Bronze, Silver, and Gold terminology explicitly when the model layer is relevant.
- Keep DP-EH Gold ownership distinct from DP-SP Gold ownership.

### IAM

- Assume IAM Roles only.
- Do not describe IAM Users as valid access patterns.

### Data Format

- Apache Iceberg is the standard Open Table Format from ISC onward.
- dbt guidance should preserve Iceberg as the target table standard where the platform persists standardized outputs.
- Do not present non-Iceberg default table patterns as the repository norm.

### Redshift

- Do not position Redshift as the platform's large-scale processing engine.
- If Redshift is referenced, treat it as a serving layer for final Data Products.
- Do not let dbt guidance shift serving concerns out of DDC and into ad hoc processing ownership.

## Modeling Rules

When generating dbt artifacts:

- include the mandatory repository header where the file type allows it
- state the model purpose
- identify whether the model belongs to DP-EH or DP-SP
- identify whether the model belongs to Bronze, Silver, or Gold
- make source-to-model intent traceable
- keep joins, filters, and derivations understandable
- make naming align with business meaning and architecture ownership
- surface assumptions that affect Data Quality or downstream interpretation

## Review Priorities

When reviewing dbt models, prioritize:

- ownership clarity
- transformation readability
- consistency with glossary terminology
- environment and component fit
- Iceberg alignment
- avoidance of Redshift-as-processing assumptions
- maintainable layering

## Prohibited Patterns

Do not:

- mix DP-EH and DP-SP ownership in one model without explicit boundary explanation
- blur enterprise Gold ownership with domain-specific Gold ownership
- use DDC as the default home for dbt transformations
- produce opaque SQL that hides business meaning
- assume IAM Users or static credentials
- present Redshift as the default batch-transformation target
- normalize non-Iceberg table patterns as repository defaults
