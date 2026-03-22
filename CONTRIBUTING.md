# Contributing

Thank you for contributing to `aws-data-platform-ai-template`.

This repository is a public, enterprise-grade foundation for AWS Data Platform Architecture using a Hub-and-Spoke model. Contributions should strengthen the repository as a consistent architecture system, not add isolated content that drifts from the established model.

## Contribution Principles

All contributions should be:

- aligned with the repository glossary, architecture, environment model, and service-mapping guidance
- generic and reusable for a public template
- explicit about architecture boundaries and responsibilities
- consistent with mandatory platform standards, including IAM Roles only, Apache Iceberg from ISC onward, and Medallion layer ownership from Landing Zone through Gold
- safe for public sharing

## Branch Strategy

Use the following branch flow:

- `feature/*` for focused changes
- `dev` for integration
- `main` for stable reviewed content

Expected contribution flow:

1. Create a focused `feature/*` branch from the appropriate base.
2. Make the change in that feature branch.
3. Open a pull request into `dev` unless the maintainers explicitly direct otherwise.
4. Promote reviewed and accepted changes from `dev` into `main`.

Do not commit directly to `main`.

Avoid mixing unrelated changes in the same branch or pull request. Keep branches small enough to review clearly.

## Pull Request Expectations

Every pull request should:

- have a clear and specific title
- describe what changed and why
- identify the affected architecture component, environment, role, template, or governance artifact when relevant
- explain any architecture, governance, or service-mapping implications
- remain consistent with the glossary and existing repository terminology
- avoid unrelated cleanup unless it is necessary to complete the change safely

When relevant, the pull request description should also state:

- which architecture component is affected: `ISC`, `DP-EH`, `DP-SP`, `DCS`, or `DDC`
- which environments are affected: `DIT`, `DEV`, `QA`, `PPRD`, or `PRD`
- whether the change reinforces or depends on mandatory standards such as IAM Roles only, Apache Iceberg, Redshift serving boundaries, or Medallion layer boundaries

Before opening a pull request, check that the change does not:

- blur Hub and Spoke responsibilities
- contradict the controlled vocabulary in `docs/architecture-glossary.md`
- contradict `docs/architecture/hub-spoke-overview.md`
- introduce enterprise-confidential assumptions into the public repository

## Mandatory Code Header Rule

All generated or contributed code and script files must include a header at the top of the file.

The header is mandatory for:

- Python
- SQL
- Terraform
- shell scripts
- PySpark
- dbt SQL models
- other code or script artifacts added to this repository

Required header fields:

- `License`
- `Author`
- `Date Created`
- `Date Modified`
- `Purpose`

Required content standard:

- License should be `Apache 2.0`
- Author should follow the repository standard
- Dates should use `YYYY-MM-DD`
- Purpose should be short, explicit, and technically meaningful

Example shell-style header:

```bash
# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: YYYY-MM-DD
# Date Modified: YYYY-MM-DD
# Purpose: Short clear description of what the code or script does
```

Example SQL-style header:

```sql
-- License: Apache 2.0
-- Author: Manuel Hernandez Giuliani
-- Date Created: YYYY-MM-DD
-- Date Modified: YYYY-MM-DD
-- Purpose: Short clear description of what the code or script does
```

If the file type uses a different comment style, adapt the same fields to the correct syntax. Do not omit the header.

## Public-Safe Contribution Rules

This repository is public. All contributions must be safe for public sharing.

Do not add:

- internal company names unless they are already intentionally part of the public repository
- internal URLs, tickets, account identifiers, or private system references
- enterprise-confidential operating procedures
- secrets, tokens, passwords, private endpoints, or hidden infrastructure details
- private datasets, private schemas, or organization-restricted examples presented as repository defaults

When enterprise-specific adaptation is needed, describe it as a downstream private extension pattern rather than adding it to the public core repository.

## Architecture and Documentation Consistency

When contributing documentation, prompts, instructions, templates, or code, keep the following repository rules explicit:

- `ISC`, `DP-EH`, `DP-SP`, `DCS`, and `DDC` have distinct responsibilities and should not overlap
- `DP-SP` does not use `QA`
- IAM access is role-based and uses IAM Roles only
- Apache Iceberg is the standard Open Table Format from `ISC` onward
- `ISC` owns the Landing Zone only
- `DP-EH` owns enterprise Bronze, Silver, and Gold processing
- `DP-SP` owns spoke-aligned Bronze and Silver processing, plus Gold only for domain-specific Data Products or domain-specific enhancements of `DP-EH` Gold outputs
- Amazon Redshift is for serving final Data Products, not for large-scale processing
- `DDC` supports both Redshift-based serving and `S3 + Apache Iceberg + Athena` consumption patterns
- `DDC` exposes Gold Data Products to consumers and must not become a processing layer
- AI-oriented access to Bronze, Silver, or Gold must be treated as a controlled exception rather than the default consumer pattern
- data processing belongs to `DP-EH` or `DP-SP`, not to `DDC`

## Review Standard

Contributions should improve at least one of the following:

- architecture clarity
- consistency of terminology
- governance and reviewability
- engineering reuse
- AI-assisted development quality
- public-template safety

If a change adds ambiguity, duplicates an existing concept, or weakens a platform standard, it should be revised before merge.

## Questions and Scope

If a proposed contribution would introduce a new concept, new architecture responsibility, or a repository-wide rule change, align it first with the existing glossary and architecture documents before expanding it into multiple files.

Favor precise incremental improvements over broad rewrites.
