# PySpark Instructions

Use these instructions when generating or reviewing PySpark jobs, PySpark examples, or Spark-oriented processing guidance for this repository.

## Primary Objective

Produce PySpark that is readable, traceable, and aligned to the repository's processing architecture.

PySpark in this repository is not generic data scripting. It must reflect clear ownership, explicit dataflow intent, and the platform's mandatory standards.

## Mandatory Sources of Truth

Always align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

## Opinionated Defaults

- Prefer explicit transformations over compact but opaque chains.
- Prefer named intermediate DataFrames when they improve traceability.
- Prefer schema-aware and lineage-friendly logic over convenience shortcuts.
- Prefer deterministic transformations over hidden implicit behavior.
- Prefer component-specific jobs over one oversized script that mixes concerns.

## Mandatory Platform Standards

### Component Ownership

- PySpark processing belongs in DP-EH or DP-SP, and in some ingestion-oriented cases in ISC.
- Do not put primary processing logic in DDC.
- Do not use PySpark to blur Centralized Processing and Distributed Processing ownership.

### IAM

- Assume IAM Roles only.
- Do not describe IAM Users as valid runtime identities.

### Data Format

- Apache Iceberg is the mandatory Open Table Format from ISC onward.
- Jobs should read from or write to Iceberg-aligned data structures where they produce platform-standardized outputs.
- Do not treat raw Parquet, CSV, or JSON outputs as the default terminal state of platform data.

### Redshift

- Do not position Redshift as the target platform for large-scale Spark processing.
- If Redshift appears, treat it as a serving destination for final Data Products, not as the processing engine.

## Coding Rules

When generating PySpark code:

- include the mandatory repository header
- make job purpose explicit
- identify the owning architecture component
- make inputs, outputs, and transformation stages clear
- use explicit configuration placeholders instead of secrets
- keep partitioning, write mode, and data format choices visible
- include comments only where they materially improve maintainability

## Processing Guidance

- In DP-EH, favor industrialized Spark patterns suitable for enterprise-scale processing.
- In DP-SP, use PySpark when domain scale, complexity, or reuse justifies it.
- Keep enterprise-shared logic in DP-EH and domain-bounded logic in DP-SP.
- Preserve Data Quality, Metadata, and Data Lineage intent in job structure and naming.

## Review Priorities

When reviewing PySpark, prioritize:

- ownership clarity
- Iceberg compliance
- readability
- dataflow traceability
- environment fit
- governance and observability hooks
- avoidance of hidden assumptions

## Prohibited Patterns

Do not:

- write DDC processing jobs
- default to non-Iceberg terminal outputs
- hardcode secrets, ARNs, account IDs, or private endpoints
- create one script that mixes ISC, DP-EH, and DP-SP responsibilities
- write Spark jobs that treat Redshift as the platform batch engine
- produce throwaway notebook-style code and present it as production-structured output
