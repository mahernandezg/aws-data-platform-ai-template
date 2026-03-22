# Coding Standards

## Purpose

This document defines the repository coding standards for templates, examples, scripts, and generated implementation artifacts.

Its purpose is to keep code readable, architecture-aligned, and reusable as part of a public enterprise-grade template.

## General Standards

- Code must reinforce the repository architecture, not bypass it.
- Code must remain generic and public-safe.
- Code must avoid embedded confidential assumptions.
- Code must favor readability over cleverness.
- Code must make architecture ownership explicit where relevant.

## Mandatory Header Rule

All code and script files must include the mandatory repository header with:

- License
- Author
- Date Created
- Date Modified
- Purpose

This is mandatory for:

- Python
- Terraform
- SQL
- YAML where comments are supported
- JSONC or ASL JSON comments where comments are supported
- shell or script files

## Architecture Alignment

Every implementation artifact should make clear:

- which architecture component it belongs to
- which environment model it is expected to support
- which mandatory platform standards apply

At minimum, code must not contradict:

- IAM Roles only
- Apache Iceberg as the standard OTF from ISC onward
- Redshift serving only
- Medallion ownership boundaries
- multi-account and multi-region operating rules

## Security Standards

- Do not use IAM Users as the access model.
- Do not hardcode credentials, passwords, tokens, or secrets.
- Prefer AWS-managed or Secrets Manager-backed patterns where secure values are needed.
- Prefer role-based runtime access.
- Avoid examples that normalize insecure public access defaults.

## Data Standards

- Apache Iceberg is the standard table format from ISC onward.
- Redshift must not be used as the main processing engine.
- DDC must not become a hidden processing layer.
- Data movement and serving logic should preserve Medallion ownership boundaries.

## Python Standards

- Use clear function boundaries.
- Prefer explicit transformation steps.
- Keep input and output assumptions visible.
- Avoid misleading placeholder code that implies incorrect runtime behavior.
- Include a `main` entry point when appropriate.

## Terraform Standards

- Use variables and outputs intentionally.
- Keep naming and tagging patterns explicit.
- Prefer secure defaults in examples and starters.
- Avoid passing long-lived secrets through Terraform variables when a managed alternative exists.
- Keep account and component ownership visible in naming.

## SQL and dbt Standards

- SQL should be readable and traceable.
- Staging, intermediate, and curated responsibilities should stay distinct.
- Curated or Gold-serving logic must not blur DP-EH, DP-SP, and DDC ownership.
- Redshift-serving SQL should state that it belongs to DDC where relevant.

## Observability and Lineage

Where relevant, implementation artifacts should include:

- logging or observability hooks
- lineage-aware field handling
- clear load or batch metadata

Examples do not need full production observability, but they must not teach invisible or untraceable patterns as best practice.

## Review Rule

Code is acceptable for this repository only if it is:

- readable
- architecture-aligned
- secure by default for a public template
- consistent with platform standards
- realistic enough to teach a correct pattern

If code teaches the wrong pattern, it is not acceptable even if it is syntactically valid.
