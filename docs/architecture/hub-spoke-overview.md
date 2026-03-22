# Hub-and-Spoke Architecture Overview

## Purpose

This document defines the baseline Hub-and-Spoke Architecture model used by this repository.

Its purpose is to establish a shared architectural reference for platform documentation, engineering patterns, role definitions, prompts, instructions, and implementation templates across the public `aws-data-platform-ai-template` repository.

## Scope

This overview describes:

- the core architecture building blocks
- the relationship between centralized and domain-aligned services
- the expected interaction model between components
- environment applicability at a platform level
- architectural boundaries that should remain consistent across this repository

This document does not prescribe detailed implementation patterns for a specific AWS account structure, landing zone, or enterprise operating model. Those concerns should be addressed in downstream design artifacts and implementation templates.

## Architecture Intent

The Hub-and-Spoke Architecture in this repository is designed to balance two objectives that often compete in enterprise data platforms:

- centralized governance, shared capabilities, and reusable platform services
- delivery autonomy for business domains and product-aligned data teams

The architecture separates enterprise-wide capabilities from spoke-specific workloads so that shared controls can scale without forcing all data processing into a single centralized delivery model.

## Core Building Blocks

The repository uses five primary architecture components.

### ISC - Ingestion Service Center

The Ingestion Service Center is responsible for acquiring data from upstream enterprise or external sources into the platform in a governed and observable way.

Typical responsibilities include:

- Ingestion Orchestration
- source connectivity patterns
- ingestion-quality controls
- raw landing-zone handoff
- ingestion Metadata capture

### DP-EH - Data Processing Center - Enterprise Hub

The Enterprise Hub provides Centralized Processing capabilities that are shared across the platform.

Typical responsibilities include:

- enterprise-standard Transformation patterns
- shared curated datasets
- cross-domain processing logic
- common semantic or conformed data layers
- reusable orchestration and platform processing standards

### DP-SP - Data Processing Center - Spoke

The Spoke provides Distributed Processing capabilities for teams that need controlled autonomy within the platform model.

Typical responsibilities include:

- domain-specific Transformations
- domain Data Product preparation
- local business-rule implementation
- bounded delivery ownership for spoke teams

### DCS - Data Core Services

Data Core Services provide the shared platform capabilities required by all other architecture components.

Typical responsibilities include:

- identity and access foundations
- Metadata and catalog services
- Data Governance controls
- orchestration foundations
- Observability and operational controls
- shared security and platform services

### DDC - Data Distribution Center

The Data Distribution Center is responsible for publishing and delivering data to downstream consumers and serving consumption patterns in a controlled way.

Typical responsibilities include:

- Data Distribution
- governed access for consumers
- query and serving interfaces
- downstream integration enablement
- distribution controls and traceability

## High-Level Interaction Model

The expected architecture flow for this repository is:

- ISC -> DDC
- DDC <-> DP-EH
- DDC <-> DP-SP
- DCS -> ISC
- DCS -> DP-EH
- DCS -> DP-SP
- DCS -> DDC

These relationships should be interpreted as follows.

### Ingestion to distribution handoff

ISC moves ingested data into platform-managed distribution or storage layers where it becomes available for governed downstream processing and consumption patterns.

### Distribution with enterprise processing

DDC and DP-EH interact bidirectionally because enterprise hub processing may consume distributed data assets and may also publish curated outputs back for enterprise-wide consumption.

### Distribution with spoke processing

DDC and DP-SP interact bidirectionally because spoke teams may consume shared distributed datasets and may also publish domain-owned outputs for broader use.

### Core services as a Control Plane

DCS supports ISC, DP-EH, DP-SP, and DDC through shared governance, Metadata, access control, orchestration support, Observability, and platform-wide operational services.

## Centralization and Autonomy Boundaries

The architecture intentionally separates what should be centralized from what can be delegated.

### Centralized concerns

The following concerns should usually remain centralized or strongly standardized:

- platform governance guardrails
- shared Metadata management
- enterprise-wide security patterns
- common access-control foundations
- shared Observability and auditability
- reusable Ingestion and Distribution standards

### Delegated spoke concerns

The following concerns can be delegated to spoke-aligned delivery teams within approved boundaries:

- domain Transformation logic
- domain release cadence
- domain Data Product ownership
- domain-specific orchestration details
- bounded workload configuration

### Boundary rule

Spokes should extend the platform through approved patterns, not bypass shared governance controls defined by DCS and enterprise-wide Distribution principles defined by DDC.

## Environment Applicability

The architecture uses the following environment model:

- DIT
- DEV
- QA
- PPRD
- PRD

Environment usage by component is:

- ISC: DIT, DEV, QA, PPRD, PRD
- DP-EH: DIT, DEV, QA, PPRD, PRD
- DCS: DIT, DEV, QA, PPRD, PRD
- DDC: DIT, DEV, QA, PPRD, PRD
- DP-SP: DIT, DEV, PPRD, PRD

The absence of `QA` for `DP-SP` reflects the repository rule that spoke environments do not use a standalone QA stage in the same way as shared platform services.

## Typical AWS Service Alignment

This repository favors AWS-native patterns. The following service categories are commonly aligned to the architecture components.

### ISC

- Amazon S3
- AWS Glue
- AWS Glue Crawler
- AWS Glue API
- Amazon EventBridge
- Amazon SQS
- AWS Lambda
- AWS Step Functions
- Apache Iceberg

### DP-EH

- AWS Glue
- Apache Spark or PySpark
- dbt
- Amazon EMR
- Amazon Redshift
- Apache Iceberg

### DP-SP

- AWS Glue
- Apache Spark or PySpark
- dbt
- AWS Glue Studio
- AWS Glue DataBrew
- Amazon S3
- Apache Iceberg
- AWS Step Functions

### DCS

- AWS IAM
- AWS Lake Formation
- AWS Secrets Manager
- AWS CloudWatch
- AWS CloudTrail
- Dynatrace
- Amazon EventBridge

### DDC

- Amazon Athena
- Amazon Redshift
- Amazon S3
- Apache Iceberg
- JDBC endpoints

This mapping is directional, not restrictive. More detailed service-to-component guidance belongs in `docs/aws-toolkit/service-mapping.md`.

## Design Principles

The Hub-and-Spoke Architecture in this repository should be extended using the following principles.

### Clear responsibility boundaries

Each component should have a distinct mission and should not absorb responsibilities that properly belong to another component.

### Governance by design

Security, Metadata, access control, auditability, and Observability should be embedded into platform patterns rather than added as afterthoughts.

### Reuse before duplication

Shared enterprise capabilities should be provided once through DCS, DDC, or DP-EH patterns before creating spoke-specific variants.

### Controlled domain autonomy

Spokes should have enough independence to deliver domain value quickly, but not in ways that fragment governance, Data Lineage, or platform standards.

### Public template safety

All architecture artifacts in this repository must remain generic, reusable, and safe for public sharing without exposing enterprise-confidential assumptions.

## Repository Implications

This overview should be treated as the baseline reference when authoring:

- the architecture glossary
- individual architecture component documents
- role definitions
- environment documentation
- AWS service mapping guidance
- GitHub prompt and instruction artifacts
- implementation templates and examples

If a future artifact conflicts with this document, the conflict should be resolved explicitly rather than silently introducing alternative terminology or flow assumptions.

## Out of Scope

This document does not define:

- account-level network topology
- organization-specific IAM policies
- confidential enterprise operating procedures
- detailed CI/CD workflows
- implementation-ready Terraform, PySpark, dbt, or orchestration code

Those artifacts should be added incrementally in dedicated documents and templates while preserving the boundaries defined here.
