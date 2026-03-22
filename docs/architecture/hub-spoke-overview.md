# Hub-and-Spoke Architecture Overview

## Purpose

This document defines the baseline Hub-and-Spoke architecture model used by this repository.

Its purpose is to establish a shared architectural reference for platform documentation, engineering patterns, role definitions, and implementation templates across the public `aws-data-platform-ai-template` repository.

## Scope

This overview describes:

- the core architecture building blocks
- the relationship between centralized and domain-oriented services
- the expected interaction model between components
- environment applicability at a platform level
- architectural boundaries that should remain consistent across this repository

This document does not prescribe detailed implementation patterns for a specific AWS account structure, landing zone, or enterprise operating model. Those concerns should be addressed in downstream design artifacts and implementation templates.

## Architecture Intent

The Hub-and-Spoke model in this repository is designed to balance two objectives that often compete in enterprise data platforms:

- centralized governance, shared capabilities, and reusable platform services
- delivery autonomy for business domains and product-aligned data teams

The architecture separates enterprise-wide capabilities from spoke-specific workloads so that shared controls can scale without forcing all data processing into a single centralized delivery model.

## Core Building Blocks

The repository uses five primary architecture components.

### ISC - Ingestion Service Center

The Ingestion Service Center is responsible for acquiring data from upstream enterprise or external sources into the platform in a governed and observable way.

Typical responsibilities include:

- ingestion orchestration
- source connectivity patterns
- ingestion-quality controls
- raw landing-zone handoff
- ingestion metadata capture

### DP-EH - Data Processing Center, Enterprise Hub

The Enterprise Hub provides centralized data processing capabilities that are shared across the organization.

Typical responsibilities include:

- enterprise-standard transformation patterns
- shared curated datasets
- cross-domain processing logic
- common semantic or conformed data layers
- reusable orchestration and platform processing standards

### DP-SP - Data Processing Center, Spoke

The Spoke provides domain-aligned processing capabilities for teams that need controlled autonomy within the platform model.

Typical responsibilities include:

- domain-specific transformations
- domain data product preparation
- local business-rule implementation
- bounded delivery ownership for spoke teams

### DCS - Data Core Services

Data Core Services provide the shared platform capabilities required by all other architecture components.

Typical responsibilities include:

- identity and access foundations
- metadata and catalog services
- governance controls
- orchestration foundations
- observability and operational controls
- shared security and platform services

### DDC - Data Distribution Center

The Distribution Center is responsible for publishing and delivering data to downstream consumers and serving consumption patterns in a controlled way.

Typical responsibilities include:

- data publishing
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

### Core services as a control plane

DCS supports ISC, DP-EH, DP-SP, and DDC through shared governance, metadata, access control, orchestration support, observability, and platform-wide operational services.

## Centralization and Autonomy Boundaries

The architecture intentionally separates what should be centralized from what can be delegated.

### Centralized concerns

The following concerns should usually remain centralized or strongly standardized:

- platform governance guardrails
- shared metadata management
- enterprise-wide security patterns
- common access-control foundations
- shared observability and auditability
- reusable ingestion and distribution standards

### Delegated spoke concerns

The following concerns can be delegated to spoke-aligned delivery teams within approved boundaries:

- domain transformation logic
- domain release cadence
- domain data product ownership
- domain-specific orchestration details
- bounded workload configuration

### Boundary rule

Spokes should extend the platform through approved patterns, not bypass shared governance controls defined by DCS and enterprise-wide distribution principles defined by DDC.

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

### DP-EH

- AWS Glue
- Apache Spark or PySpark
- DBT
- Amazon EMR
- Amazon Redshift
- Apache Iceberg

### DP-SP

- AWS Glue
- Apache Spark or PySpark
- DBT
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
- JDBC endpoints
- APIs and controlled distribution interfaces

This mapping is directional, not restrictive. More detailed service-to-component guidance belongs in `docs/aws-toolkit/service-mapping.md`.

## Design Principles

The Hub-and-Spoke architecture in this repository should be extended using the following principles.

### Clear responsibility boundaries

Each component should have a distinct mission and should not absorb responsibilities that properly belong to another component.

### Governance by design

Security, metadata, access control, auditability, and observability should be embedded into platform patterns rather than added as afterthoughts.

### Reuse before duplication

Shared enterprise capabilities should be provided once through DCS, DDC, or DP-EH patterns before creating spoke-specific variants.

### Controlled domain autonomy

Spokes should have enough independence to deliver domain value quickly, but not in ways that fragment governance, lineage, or platform standards.

### Public template safety

All architecture artifacts in this repository must remain generic, reusable, and safe for public sharing without exposing enterprise-confidential assumptions.

## Repository Implications

This overview should be treated as the baseline reference when authoring:

- the architecture glossary
- individual architecture component documents
- role definitions
- environment documentation
- AWS service mapping guidance
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
# Hub-and-Spoke Overview

## Purpose

This document defines the repository-level Hub-and-Spoke architecture model for the `aws-data-platform-ai-template`.

Its purpose is to provide a clear and reusable architectural baseline for AWS-based enterprise data platforms that need to balance:

- centralized governance and shared capabilities
- scalable domain delivery
- consistent environment usage
- enterprise-grade operational clarity

This overview is intentionally generic so it can remain suitable for a public repository while still being detailed enough to guide downstream implementation and design decisions.

## Scope

This document covers:

- the architectural role of each major platform building block
- the interaction model between centralized and spoke-aligned components
- the control and data boundaries of the platform
- environment applicability across the architecture
- high-level AWS service alignment

This document does not define:

- component-level implementation details
- organization-specific operating models
- detailed network, IAM, or account topologies
- workload-specific data product designs

## Architecture Model

The repository uses a Hub-and-Spoke data platform model composed of five major building blocks:

- ISC: Ingestion Service Center
- DP-EH: Data Platform Enterprise Hub
- DP-SP: Data Platform Spoke
- DCS: Data Core Services
- DDC: Data Distribution Center

The model separates shared enterprise capabilities from spoke-specific delivery capabilities while preserving a common governance, metadata, and operational framework.

## Architectural Intent

The Hub-and-Spoke model exists to solve three recurring enterprise needs:

- provide shared platform capabilities once and reuse them across many teams
- allow spoke domains to deliver data products without depending on a fully centralized delivery model
- maintain governance, observability, security, and lifecycle consistency across environments

In this repository, the hub is not only a technical integration point. It is also the place where enterprise-wide controls, standards, reusable services, and common data platform capabilities are coordinated.

## Component Overview

### ISC: Ingestion Service Center

ISC is the entry point for managed ingestion into the platform.

Its primary responsibilities are:

- receiving or collecting source-aligned data feeds
- standardizing ingestion orchestration patterns
- enforcing ingestion-level controls and technical validation
- integrating with shared metadata, secrets, and operational services

ISC is typically responsible for controlled onboarding of batch, event, file-based, or service-driven data ingestion workloads.

### DP-EH: Data Platform Enterprise Hub

DP-EH is the centralized enterprise processing and enablement layer.

Its primary responsibilities are:

- hosting reusable transformation and processing capabilities
- implementing shared enterprise logic and cross-domain processing patterns
- providing centrally managed services that should not be duplicated in each spoke
- enabling standard platform patterns for quality, lineage, governance, and orchestration

DP-EH should be used when consistency, reuse, or centralized control provides material value across multiple domains.

### DP-SP: Data Platform Spoke

DP-SP represents domain-aligned processing and delivery capability.

Its primary responsibilities are:

- implementing spoke-specific transformation logic
- supporting domain-owned data product workflows
- enabling delivery autonomy within approved enterprise guardrails
- integrating with shared platform services without duplicating central platform concerns

DP-SP should preserve domain focus. It is not intended to become an uncontrolled alternative to the enterprise hub.

### DCS: Data Core Services

DCS provides foundational shared services used across the architecture.

Its primary responsibilities are:

- identity and access support patterns
- metadata and catalog enablement
- governance and control plane capabilities
- observability, audit, and operational support services
- shared service integrations required by multiple architecture components

DCS is the architectural backbone that supports consistency across ISC, DP-EH, DP-SP, and DDC.

### DDC: Data Distribution Center

DDC is the controlled distribution and consumption layer of the platform.

Its primary responsibilities are:

- exposing curated data assets for downstream consumption
- supporting controlled distribution patterns for analytics and data sharing
- separating platform-internal processing concerns from consumer-facing access concerns
- integrating with central governance, access controls, and observability

DDC helps ensure that distribution is managed as a first-class architectural concern rather than an afterthought of processing pipelines.

## High-Level Interaction Model

The expected interaction model for this repository is:

- ISC -> DDC
- DDC <-> DP-EH
- DDC <-> DP-SP
- DCS -> ISC
- DCS -> DP-EH
- DCS -> DP-SP
- DCS -> DDC

These relationships express architectural intent rather than mandating a single deployment topology.

### Interaction meaning

- `ISC -> DDC` means ingestion workloads ultimately feed controlled downstream distribution paths through the governed platform.
- `DDC <-> DP-EH` means enterprise processing and enterprise distribution are tightly coordinated for shared data assets and cross-domain consumption.
- `DDC <-> DP-SP` means spoke-owned outputs may be distributed through governed enterprise distribution channels, and downstream demand may shape spoke delivery patterns.
- `DCS -> *` means shared core services support every other major architecture component.

## Control and Data Boundaries

The model separates responsibilities across two primary boundary types.

### Control boundaries

Control boundaries define where governance and operational decisions should be enforced, including:

- IAM and access control patterns
- metadata registration and catalog usage
- observability and audit requirements
- environment promotion rules
- reusable orchestration and operational standards

Most control boundaries are centralized through DCS and coordinated through the hub-oriented parts of the platform.

### Data boundaries

Data boundaries define where data is ingested, processed, governed, and distributed.

- ISC focuses on controlled entry into the platform.
- DP-EH focuses on shared and enterprise-wide processing.
- DP-SP focuses on domain-specific processing responsibilities.
- DDC focuses on governed exposure and distribution.

This separation improves clarity of ownership and reduces the risk of mixing ingestion, transformation, and consumption concerns inside a single undifferentiated platform layer.

## Environment Applicability

The repository uses the following environment model:

- DIT: Sandbox
- DEV: Development
- QA: Quality Assurance
- PPRD: Pre-Production
- PRD: Production

Environment applicability by architecture component is:

- ISC: DIT, DEV, QA, PPRD, PRD
- DP-EH: DIT, DEV, QA, PPRD, PRD
- DCS: DIT, DEV, QA, PPRD, PRD
- DDC: DIT, DEV, QA, PPRD, PRD
- DP-SP: DIT, DEV, PPRD, PRD

The absence of QA for DP-SP reflects a different validation lifecycle for spoke-aligned delivery. This should not reduce quality expectations. It means validation controls are expected to be designed differently for spokes than for centrally managed shared services.

## Typical AWS Service Alignment

The architecture can be implemented with multiple AWS-native services depending on the use case. Typical alignment includes:

- ISC: AWS Glue, AWS Lambda, Amazon SQS, Amazon MSK, Amazon EventBridge, Amazon S3
- DP-EH: AWS Glue, Apache Spark, AWS Step Functions, Apache Airflow, Amazon EMR, Amazon Redshift
- DP-SP: AWS Glue, dbt, Apache Spark, Amazon Athena, Amazon S3
- DCS: AWS IAM, AWS Lake Formation, AWS Secrets Manager, AWS CloudWatch, AWS CloudTrail
- DDC: Amazon S3, Amazon Athena, Amazon Redshift, Apache Iceberg, JDBC-based access patterns

These mappings are indicative and should be refined by component-level documents and service-mapping guidance.

## Design Principles

The following principles should guide repository artifacts that build on this model:

- keep shared enterprise capabilities distinct from spoke-specific capabilities
- use DCS to avoid duplicating foundational controls across components
- treat distribution as a governed platform function, not only an output of pipelines
- prefer AWS-native patterns when they improve operational clarity and maintainability
- make environment applicability explicit in design and implementation artifacts
- keep the public repository generic and free from enterprise-confidential details

## Responsibilities and Ownership Model

At a high level:

- centralized platform teams typically own shared controls, common services, and reusable hub capabilities
- domain-aligned teams typically own spoke-specific processing and data product delivery within approved guardrails
- platform governance responsibilities should remain explicit even when delivery execution is decentralized

This repository should therefore document both shared platform responsibilities and spoke responsibilities without collapsing them into a single generic ownership model.

## When to Use Hub vs Spoke Patterns

Use hub-oriented patterns when:

- a capability must be standardized across many domains
- governance consistency is more important than local variation
- enterprise-wide reuse justifies central implementation
- shared data assets or cross-domain processing are involved

Use spoke-oriented patterns when:

- the workload is domain-specific
- local delivery autonomy materially improves throughput or accountability
- the capability does not need enterprise-wide centralization
- the spoke can operate within shared governance boundaries without duplicating core services

## Related Documents

This overview should be read alongside:

- `docs/architecture-glossary.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`
- `docs/roles/*.md`

These supporting documents should inherit terminology and architectural boundaries from this overview.
