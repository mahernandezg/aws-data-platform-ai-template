# Data Engineer

## Purpose

This document defines the Data Engineer role within the `aws-data-platform-ai-template`.

Its purpose is to clarify how Data Engineers contribute to an AWS-native enterprise data platform that follows the Hub-and-Spoke Architecture model used by this repository.

This role definition is intended to support:

- consistent responsibility boundaries
- clear delivery expectations
- effective collaboration with platform, architecture, DevOps, QA, and product roles
- reusable public guidance for enterprise-grade data engineering practices

## Scope

The Data Engineer role is responsible for implementing, testing, operating, and maintaining data pipelines and transformation workloads that move data through the platform in a governed, observable, and reusable way.

The role applies across the following architecture components when data movement or transformation work is required:

- ISC
- DP-EH
- DP-SP
- DDC

The role operates within the guardrails, controls, and shared services provided by DCS.

The Data Engineer may contribute technical design decisions inside those guardrails, but does not own end-to-end data architecture, business-rule design, or platform-boundary definition. Those responsibilities remain with the Data Architect, Cloud Architect, and Data Platforms Architect as appropriate.

## Mission

The mission of the Data Engineer is to convert approved platform and business requirements into reliable, traceable, and maintainable data flows that align with enterprise architecture standards and AWS-native delivery patterns.

The Data Engineer should enable data availability and Transformation without weakening governance, Observability, Data Quality, or environment discipline.

## Architecture Alignment

The Data Engineer works differently depending on the architecture component being addressed.

### ISC

Within ISC, the Data Engineer focuses on:

- building Ingestion pipelines
- implementing source-to-platform landing patterns
- applying ingestion validations and technical quality checks
- ensuring operational traceability for Ingestion jobs

### DP-EH

Within DP-EH, the Data Engineer focuses on:

- implementing shared Transformation logic
- building reusable enterprise processing pipelines
- maintaining cross-domain processing consistency
- supporting curated and conformed data structures

### DP-SP

Within DP-SP, the Data Engineer focuses on:

- implementing domain-specific Transformation logic
- preparing spoke-owned Data Products
- applying approved enterprise patterns in a domain context
- balancing delivery autonomy with platform standards

### DDC

Within DDC, the Data Engineer focuses on:

- preparing governed publish-ready datasets
- implementing controlled Distribution-ready structures
- supporting query-ready and consumer-facing serving structures
- preserving Data Lineage and traceability from source to published outputs

### DCS relationship

The Data Engineer does not own DCS as a platform domain, but relies on DCS capabilities such as:

- Metadata and catalog services
- access and security controls
- secrets management
- Observability and audit foundations
- shared orchestration and governance services

## Core Responsibilities

The Data Engineer is expected to:

- implement ingestion, Transformation, and Distribution-ready data pipelines
- develop batch, event-driven, or scheduled workloads using approved AWS-native or repository-aligned tooling
- create readable, maintainable, and testable data processing logic
- apply Data Quality checks appropriate to the pipeline stage
- register or integrate datasets with Metadata and catalog standards
- support Data Lineage, logging, and operational Observability
- align data structures and workflows to the relevant architecture component
- promote changes through the approved environment model
- document implementation assumptions, interfaces, and operational expectations
- collaborate with architects and DevOps engineers on deployment-ready patterns

## Typical Deliverables

Typical Data Engineer deliverables include:

- Ingestion jobs and workflow definitions
- Transformation logic in PySpark, SQL, dbt, or AWS-native processing services
- dataset contracts and interface assumptions
- curated data structures for analytics or downstream Distribution
- Data Quality rules and validation logic
- operational runbook inputs for pipeline support
- engineering documentation for pipeline behavior and dependencies
- pull requests aligned with repository structure and architecture terminology

## Typical AWS and Engineering Tooling

The Data Engineer commonly works with:

- AWS Glue
- AWS Glue Studio
- AWS Glue Crawler
- AWS Glue Data Catalog
- AWS Glue Data Quality
- Amazon S3
- AWS Lambda
- AWS Step Functions
- Amazon EventBridge
- Amazon SQS
- Apache Spark
- PySpark
- dbt
- Amazon Athena
- Amazon Redshift
- Apache Iceberg

Tool selection should favor AWS-native clarity, operational maintainability, and compatibility with shared platform governance.

Mandatory repository standards remain:

- IAM access uses IAM Roles only
- Apache Iceberg is the standard Open Table Format from ISC onward
- Amazon Redshift is not the primary engine for large-scale Transformation or heavy batch processing
- DP-EH favors Spark, Glue, and dbt for enterprise-scale processing
- DP-SP may use the same industrialized stack or lighter tools such as Glue Studio and DataBrew
- DDC supports Redshift and S3 plus Apache Iceberg plus Athena as consumption patterns, not as primary processing patterns

## Key Decisions Owned by the Role

The Data Engineer typically makes or strongly influences decisions such as:

- how a pipeline should be structured for readability and maintainability
- how Transformations should be decomposed into staging, intermediate, and curated steps
- which approved processing service best fits a given data workload
- how to implement data validation within the pipeline lifecycle
- how to structure schema handling, partitioning, and Transformation flow
- how to expose operational telemetry needed for supportability

These decisions should remain aligned with architecture guidance, platform controls, and environment rules.

## Boundaries

The Data Engineer role does not independently own:

- platform-wide architecture decisions
- end-to-end data architecture
- business-rule design ownership
- enterprise security policy definition
- IAM governance design
- organization-wide infrastructure standards
- final production release governance
- backlog prioritization and product scope ownership

The Data Engineer should not bypass DCS controls, redefine architecture boundaries, or introduce ad hoc platform patterns that weaken standardization.

The Data Engineer should implement within approved architecture rather than redefine component responsibilities or Data Product semantics.

## Collaboration Points

The Data Engineer works closely with the following roles.

### Data Platforms Architect

Collaboration focuses on:

- architecture fit
- component responsibilities
- processing-pattern selection
- alignment with Hub-and-Spoke boundaries

### Cloud Architect

Collaboration focuses on:

- AWS service choices
- cloud design constraints
- integration with enterprise cloud patterns

### Data Architect

Collaboration focuses on:

- translating end-to-end data design into implementable pipelines
- implementing business-rule intent without redefining it
- preserving data-model and Data Contract expectations in code

### Cloud DevOps

Collaboration focuses on:

- deployment automation
- environment promotion
- infrastructure dependencies
- operationalization and monitoring integration

### Data QA Engineer

Collaboration focuses on:

- test strategy
- validation coverage
- defect analysis
- quality gates for data pipelines and outputs

### Technical Product Owner

Collaboration focuses on:

- delivery scope
- acceptance criteria
- Data Product expectations
- sequencing of engineering work

## Environment Applicability

The Data Engineer must work within the repository environment model:

- DIT
- DEV
- QA
- PPRD
- PRD

Environment expectations vary by architecture component:

- ISC, DP-EH, DCS, and DDC follow DIT, DEV, QA, PPRD, PRD
- DP-SP follows DIT, DEV, PPRD, PRD

This means Data Engineers working on spoke-aligned workloads must design validation and release practices that respect the absence of a standalone QA environment for DP-SP.

## Engineering Expectations

Data Engineer outputs in this repository should be:

- readable by humans first
- modular and maintainable
- observable in operation
- explicit about assumptions and dependencies
- aligned to environment promotion discipline
- compatible with Metadata, security, and governance controls
- safe for public-template reuse

Where code is introduced, it must include the repository-mandated header fields:

- License
- Author
- Date Created
- Date Modified
- Purpose

## Success Criteria

The Data Engineer role is successful when:

- Ingestion and Transformation pipelines are reliable and supportable
- datasets move through the platform with traceable Data Lineage and clear ownership
- engineering outputs align with the Hub-and-Spoke Architecture
- platform controls are adopted without blocking delivery unnecessarily
- domain delivery remains consistent with enterprise standards
- implementation artifacts are reusable, understandable, and production-oriented

## Out of Scope

This role definition does not prescribe:

- detailed coding standards for every language
- organization-specific team topology
- confidential enterprise operating procedures
- a single mandatory implementation toolchain for every workload

Those concerns should be addressed in supporting repository artifacts and downstream enterprise-specific adaptations.
