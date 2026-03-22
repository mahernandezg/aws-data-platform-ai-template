# Data QA Engineer

## Purpose

This document defines the Data QA Engineer role within the `aws-data-platform-ai-template`.

Its purpose is to clarify how the Data QA Engineer ensures that data platform changes are validated for correctness, reliability, quality, and fitness for use across the repository's Hub-and-Spoke architecture.

This role definition is intended to support:

- clear ownership of data quality validation responsibilities
- consistent test and validation practices across platform components
- alignment between data semantics, engineering implementation, and release quality
- reusable public guidance for enterprise-grade data quality assurance

## Scope

The Data QA Engineer role is responsible for defining, organizing, and executing validation approaches for data platform artifacts and behaviors.

This includes:

- validating data pipelines and data products
- defining quality gates for environment promotion
- verifying data transformations against expected business and technical outcomes
- supporting defect analysis and quality feedback loops
- aligning validation practices with architecture boundaries and environment rules

The Data QA Engineer does not primarily define platform architecture, implement production pipelines, or own business-priority decisions.

## Mission

The mission of the Data QA Engineer is to ensure that platform outputs are trustworthy, traceable, and validated before they are promoted across environments or exposed for downstream use.

The Data QA Engineer should make quality visible and actionable without slowing delivery through unclear or inconsistent validation practices.

## Architecture Alignment

The Data QA Engineer contributes across all major architecture components by defining how quality should be assessed at each stage of the platform.

### ISC

Within ISC, the Data QA Engineer focuses on:

- validating ingestion completeness and correctness
- verifying source-to-platform landing behavior
- assessing ingestion controls, schema expectations, and rejection handling
- confirming observability for ingestion failures and anomalies

### DP-EH

Within DP-EH, the Data QA Engineer focuses on:

- validating shared transformation logic
- verifying conformed and reusable dataset outcomes
- assessing quality controls for centralized processing patterns
- confirming that enterprise-level transformations behave consistently across environments

### DP-SP

Within DP-SP, the Data QA Engineer focuses on:

- validating domain-specific transformation outcomes
- ensuring spoke-owned data products meet defined quality expectations
- adapting validation approaches to the DP-SP lifecycle without a standalone QA environment
- preserving consistency between local spoke delivery and enterprise quality standards

### DDC

Within DDC, the Data QA Engineer focuses on:

- validating published and distributed data assets
- checking consumer-facing dataset correctness and usability
- confirming lineage, access expectations, and distribution quality controls
- assessing downstream-readiness of governed outputs

### DCS relationship

The Data QA Engineer relies on DCS capabilities to support quality assurance through:

- metadata and catalog visibility
- audit and observability foundations
- access-controlled validation environments
- shared governance and control mechanisms

## Core Responsibilities

The Data QA Engineer is expected to:

- define validation approaches for data pipelines, datasets, and platform behaviors
- create and maintain test scenarios for technical and data-quality outcomes
- verify that platform outputs satisfy functional, structural, and quality expectations
- assess defects, anomalies, and quality regressions across environments
- support quality gates for release and promotion workflows
- collaborate with engineering and architecture roles to clarify expected behavior
- ensure validation reflects both technical correctness and intended data meaning
- document quality assumptions, test coverage, and unresolved risks
- promote repeatable and reviewable data quality practices across shared and spoke-aligned workloads

## Typical Deliverables

Typical Data QA Engineer deliverables include:

- data validation test scenarios
- quality gate definitions
- test evidence and validation summaries
- defect reports and analysis notes
- data reconciliation and rule-verification approaches
- environment-specific validation plans
- quality review input for releases and promotions
- recommendations for improving testability and quality observability

## Typical AWS and Engineering Tooling

The Data QA Engineer commonly works with:

- AWS Glue Data Quality
- AWS Glue
- Amazon Athena
- Amazon S3
- Amazon Redshift
- Apache Spark or PySpark-based validation patterns
- SQL-based validation logic
- metadata and catalog services used by the platform
- observability tools such as AWS CloudWatch and Dynatrace

Tooling choices should favor traceability, repeatability, clarity of evidence, and compatibility with platform governance.

## Key Decisions Owned by the Role

The Data QA Engineer typically owns or strongly influences decisions such as:

- what must be validated before a workload or dataset can progress across environments
- how validation coverage should be structured for ingestion, transformation, and distribution stages
- how to distinguish data defects from implementation defects or environment issues
- how quality gates should be applied in shared versus spoke-aligned workflows
- how test evidence should be recorded and communicated to delivery teams
- how quality risks should be escalated when validation is incomplete or insufficient

These decisions should remain aligned with architecture intent, environment rules, and delivery practicality.

## Boundaries

The Data QA Engineer role does not primarily own:

- platform architecture decisions
- cloud architecture design
- business-domain prioritization
- direct implementation of production pipelines as a primary responsibility
- infrastructure deployment ownership
- product-scope decision making

The Data QA Engineer should not replace the Data Engineer, Data Architect, Cloud Architect, Cloud DevOps, or Technical Product Owner roles. The role is accountable for quality validation and assurance, not for owning all implementation or product responsibilities.

## Collaboration Points

The Data QA Engineer works closely with the following roles.

### Data Engineer

Collaboration focuses on:

- validating pipeline behavior and transformation outcomes
- reproducing and analyzing data defects
- improving testability and operational quality signals

### Data Architect

Collaboration focuses on:

- validating that outputs reflect intended business rules and data model expectations
- clarifying semantic acceptance criteria for datasets and flows

### Data Platforms Architect

Collaboration focuses on:

- aligning validation expectations with platform boundaries and architecture principles
- understanding architecture-driven quality constraints across components

### Cloud DevOps

Collaboration focuses on:

- integrating validation into release and promotion workflows
- ensuring environments and automation support reliable testing

### Cloud Architect

Collaboration focuses on:

- clarifying non-functional and environment-level conditions that affect validation outcomes

### Technical Product Owner

Collaboration focuses on:

- agreeing on acceptance criteria, quality expectations, and release readiness signals

## Environment Applicability

The Data QA Engineer works within the full repository environment model:

- DIT
- DEV
- QA
- PPRD
- PRD

Environment applicability by component remains:

- ISC, DP-EH, DCS, and DDC follow DIT, DEV, QA, PPRD, PRD
- DP-SP follows DIT, DEV, PPRD, PRD

The Data QA Engineer must adapt quality assurance practices to the absence of a standalone QA environment for DP-SP while maintaining equivalent confidence in spoke-aligned releases.

## Quality Expectations

Data QA Engineer outputs in this repository should be:

- evidence-based
- traceable to expected behavior
- clear about assumptions and coverage boundaries
- aligned to environment promotion discipline
- compatible with platform governance and observability controls
- practical for engineering and platform teams to act on
- generic enough for safe public-template reuse

The role should favor explicit validation logic and reproducible evidence over informal or ambiguous quality judgments.

## Success Criteria

The Data QA Engineer role is successful when:

- defects and regressions are detected early and communicated clearly
- data outputs are validated against both technical and semantic expectations
- release and promotion decisions are supported by visible quality evidence
- shared and spoke-aligned workloads follow appropriate but consistent validation approaches
- quality practices improve confidence without creating avoidable delivery friction
- the repository promotes disciplined, reusable, and enterprise-grade quality standards

## Relationship to Other Role Artifacts

This role is distinct from:

- the Data Engineer, who implements pipelines and transformations
- the Data Architect, who defines business-rule alignment and data modeling intent
- the Cloud DevOps role, which enables deployment and operational automation
- the Data Platforms Architect, who defines overall platform architecture boundaries

The Data QA Engineer provides the validation discipline that confirms platform behavior matches intended design and release expectations.

## Out of Scope

This role definition does not prescribe:

- organization-specific testing tools not defined in this repository
- confidential quality processes or approval forums
- a single mandatory testing framework for every workload
- business ownership of release priorities

Those concerns should be handled in supporting repository artifacts or downstream private adaptations.
