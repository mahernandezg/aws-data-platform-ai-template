# Cloud Architect

## Purpose

This document defines the Cloud Architect role within the `aws-data-platform-ai-template`.

Its purpose is to clarify how the Cloud Architect designs and governs the AWS cloud foundation that supports the repository's Hub-and-Spoke data platform architecture.

This role definition is intended to support:

- clear ownership of cloud design decisions
- consistent AWS-native architecture patterns
- alignment between platform architecture and cloud implementation choices
- reusable public guidance for enterprise-grade cloud architecture

## Scope

The Cloud Architect role is responsible for defining the cloud design principles, service boundaries, and deployment patterns that enable the data platform to operate securely, reliably, and consistently across environments.

This includes:

- shaping how AWS services are selected and combined
- defining cloud-level boundaries between shared and spoke-aligned capabilities
- guiding account, network, security, and service-integration decisions at an architectural level
- ensuring that platform designs are feasible and maintainable in AWS

The Cloud Architect does not primarily implement pipelines, maintain day-to-day operations, or own product-specific business rules.

## Mission

The mission of the Cloud Architect is to ensure that the data platform is built on a coherent AWS cloud foundation that supports enterprise governance, operational stability, and scalable delivery across the Hub-and-Spoke model.

The Cloud Architect should make cloud decisions that are explicit, reusable, and compatible with both centralized platform capabilities and spoke-level delivery needs.

## Architecture Alignment

The Cloud Architect contributes across all major architecture components by defining how they should be realized in AWS.

### ISC

Within ISC, the Cloud Architect focuses on:

- source-ingestion connectivity patterns
- secure and scalable ingestion service choices
- landing-zone and storage-layer architecture considerations
- event-driven and batch integration design at cloud level

### DP-EH

Within DP-EH, the Cloud Architect focuses on:

- shared compute and orchestration patterns
- enterprise processing service selection
- cloud-level isolation and scaling considerations
- reusable platform capabilities for centralized processing

### DP-SP

Within DP-SP, the Cloud Architect focuses on:

- spoke-aligned deployment boundaries
- patterns for controlled domain autonomy
- cloud designs that allow reuse of shared services without collapsing spoke ownership
- environment and service decisions that fit spoke delivery lifecycles

### DDC

Within DDC, the Cloud Architect focuses on:

- governed distribution interfaces
- storage and query-serving architecture patterns
- secure data access paths for downstream consumers
- cloud controls that preserve distribution reliability and traceability

### DCS relationship

The Cloud Architect plays a major role in shaping how DCS capabilities are provided, including:

- IAM and access-control architecture
- secrets and configuration-management patterns
- observability and audit integration
- metadata and governance service enablement
- shared operational and control-plane capabilities

## Core Responsibilities

The Cloud Architect is expected to:

- define AWS-native reference patterns for the platform
- select appropriate AWS services for each architecture component
- establish cloud-level boundaries between shared services and spoke-specific services
- guide architecture decisions related to security, networking, identity, and service integration
- ensure platform designs remain deployable across the repository environment model
- review proposed implementations for alignment with cloud architecture intent
- identify cross-cutting cloud concerns such as resilience, access management, auditability, and operational support
- promote design consistency across templates, patterns, and role artifacts
- document assumptions, tradeoffs, and architectural rationale for major cloud decisions

## Typical Deliverables

Typical Cloud Architect deliverables include:

- cloud reference architecture guidance
- AWS service selection rationale
- account and environment boundary recommendations
- integration and connectivity patterns
- security and access boundary design notes
- cloud design inputs for architecture component documents
- review guidance for infrastructure and implementation alignment
- reusable platform patterns for shared and spoke deployments

## Typical AWS and Engineering Tooling

The Cloud Architect commonly works with:

- AWS IAM
- AWS Lake Formation
- AWS Secrets Manager
- Amazon S3
- AWS Glue
- AWS Lambda
- AWS Step Functions
- Amazon EventBridge
- Amazon SQS
- Amazon MSK
- Amazon Athena
- Amazon Redshift
- Amazon EMR
- AWS CloudWatch
- AWS CloudTrail
- Terraform

Tooling choices should favor AWS-native clarity, operational maintainability, security, and enterprise reuse.

## Key Decisions Owned by the Role

The Cloud Architect typically owns or strongly influences decisions such as:

- which AWS services should be used for each architecture component
- where cloud boundaries should exist between hub capabilities and spoke capabilities
- how identity, access, and security controls should be structured at platform level
- how environment separation should be reflected in cloud design
- how services should integrate for ingestion, processing, governance, and distribution
- how resilience, observability, and auditability should be built into the platform foundation

These decisions should be explicit enough for engineering and DevOps teams to implement without ambiguity.

## Boundaries

The Cloud Architect role does not primarily own:

- detailed business-rule design
- logical data modeling
- day-to-day infrastructure deployment execution
- pipeline implementation
- production support operations
- backlog ownership or delivery prioritization

The Cloud Architect should not replace the Data Architect, Data Engineer, Cloud DevOps, or Technical Product Owner roles. The role is accountable for cloud architecture coherence and design quality, not for owning every implementation activity.

## Collaboration Points

The Cloud Architect works closely with the following roles.

### Data Platforms Architect

Collaboration focuses on:

- overall platform architecture alignment
- component responsibilities and boundaries
- hub-and-spoke operating model consistency

### Data Architect

Collaboration focuses on:

- ensuring data-flow and modeling decisions are feasible in AWS
- translating data architecture needs into appropriate cloud patterns

### Data Engineer

Collaboration focuses on:

- giving implementation teams clear cloud design guardrails
- aligning pipeline and service usage with approved architecture patterns

### Cloud DevOps

Collaboration focuses on:

- translating cloud architecture into deployable infrastructure patterns
- ensuring automation, observability, and operational controls reflect architecture intent

### Data QA Engineer

Collaboration focuses on:

- clarifying environment and non-functional expectations that affect validation strategy

### Technical Product Owner

Collaboration focuses on:

- prioritizing cloud-enablement decisions that affect platform capabilities and delivery scope

## Environment Applicability

The Cloud Architect designs for the full repository environment model:

- DIT
- DEV
- QA
- PPRD
- PRD

Environment applicability by component remains:

- ISC, DP-EH, DCS, and DDC follow DIT, DEV, QA, PPRD, PRD
- DP-SP follows DIT, DEV, PPRD, PRD

The Cloud Architect must account for these rules when defining deployment boundaries, service topologies, promotion models, and spoke-specific patterns.

## Architectural Expectations

Cloud Architect outputs in this repository should be:

- explicit about AWS service intent
- clear about security and access boundaries
- aligned to Hub-and-Spoke responsibilities
- compatible with governance, metadata, and observability requirements
- practical for engineering and DevOps teams to implement
- generic enough for safe public-template reuse

The role should prefer well-understood AWS-native patterns over unnecessary complexity or organization-specific assumptions.

## Success Criteria

The Cloud Architect role is successful when:

- AWS service choices are coherent and fit for enterprise use
- shared and spoke cloud boundaries remain clear
- platform designs support governance, security, and operational clarity
- engineering and DevOps teams can implement the platform without architectural ambiguity
- environment models are reflected correctly in cloud design decisions
- architecture artifacts remain reusable, understandable, and aligned with repository intent

## Relationship to Other Role Artifacts

This role is distinct from:

- the Data Architect, who focuses on data flow, business rules, and data modeling
- the Data Engineer, who implements data pipelines and transformations
- the Cloud DevOps role, which operationalizes and automates cloud deployments and runtime management

The Cloud Architect defines the cloud foundation and service architecture that enable the rest of the platform roles to deliver consistently.

## Out of Scope

This role definition does not prescribe:

- organization-specific landing-zone implementations
- confidential network topology details
- vendor-specific non-AWS standards not present in this repository
- detailed runbook procedures for operational teams

Those concerns should be handled in supporting repository artifacts or downstream private adaptations.
