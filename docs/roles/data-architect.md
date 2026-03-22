# Data Architect

## Purpose

This document defines the Data Architect role within the `aws-data-platform-ai-template`.

Its purpose is to clarify how the Data Architect shapes data structures, end-to-end data flows, and business-rule alignment across an AWS-native enterprise data platform built on the Hub-and-Spoke Architecture model.

This role definition is intended to support:

- clear separation between architecture and implementation responsibilities
- consistent data modeling and flow design practices
- alignment between business requirements and technical platform design
- reusable public guidance for enterprise-grade data architecture work

## Scope

The Data Architect role is responsible for designing the end-to-end structure of data movement and data usage across the platform.

This includes:

- defining conceptual and logical data models
- shaping business-rule representation in data flows
- designing Data Domain boundaries and integration patterns
- guiding how data should move through ISC, DP-EH, DP-SP, and DDC
- ensuring that design choices remain consistent with governance and platform controls provided by DCS

The Data Architect does not primarily build pipelines, implement runtime Transformations, or own deployment automation. Those implementation responsibilities belong to Data Engineers and supporting engineering roles.

## Mission

The mission of the Data Architect is to ensure that data entering, moving through, and leaving the platform follows a coherent design that is technically sound, aligned with business meaning, and scalable across the enterprise.

The Data Architect should make the Data Platform understandable as an end-to-end system, not only as a collection of pipelines or services.

The Data Architect owns architecture intent for end-to-end data flow, business-rule placement, and data modeling. The Data Engineer implements that intent within approved platform and cloud guardrails.

## Architecture Alignment

The Data Architect contributes across all major architecture components.

### ISC

Within ISC, the Data Architect focuses on:

- defining Ingestion-layer data boundaries
- clarifying source-system assumptions and onboarding patterns
- shaping how raw or landing data should be organized for downstream use
- identifying Ingestion-related business-rule implications

### DP-EH

Within DP-EH, the Data Architect focuses on:

- defining shared enterprise data models
- guiding conformed, reusable, or cross-domain data structures
- aligning Transformation design to enterprise semantics
- preventing conflicting interpretations of core business entities

### DP-SP

Within DP-SP, the Data Architect focuses on:

- defining domain-specific models within approved enterprise boundaries
- ensuring spoke Data Products remain consistent with enterprise integration needs
- clarifying where domain autonomy is appropriate and where standardization is required
- shaping spoke-to-hub and spoke-to-Distribution Data Contracts

### DDC

Within DDC, the Data Architect focuses on:

- defining publish-ready semantic structures
- guiding consumer-facing data-model clarity
- shaping Distribution-ready datasets for analytics, reporting, or downstream integration
- ensuring business meaning is preserved in exposed data assets

### DCS relationship

The Data Architect relies on DCS capabilities to ensure architectural designs remain compatible with:

- Metadata standards
- catalog structures
- access-control boundaries
- Data Lineage and Observability expectations
- shared governance controls

## Core Responsibilities

The Data Architect is expected to:

- design end-to-end data flows across the Hub-and-Spoke platform
- define conceptual, logical, and high-level physical data-modeling guidance
- translate business concepts into durable data structures and Transformation boundaries
- identify where business rules should be represented in the data lifecycle
- define where business rules belong in the end-to-end data flow
- define integration patterns between source, processing, and Distribution layers
- establish Data Contracts, entity definitions, and domain boundaries
- guide how shared and spoke-specific datasets should relate to one another
- align data design choices with platform governance and environment rules
- review implementation proposals for consistency with the intended data architecture
- document assumptions, tradeoffs, and design rationale for data structures and flows

Mandatory repository standards must remain part of that architecture intent:

- IAM access uses IAM Roles only
- Apache Iceberg is the standard Open Table Format from ISC onward
- Amazon Redshift is limited to serving final Data Products rather than acting as the default processing engine
- DP-EH favors Spark, Glue, and dbt for enterprise-scale processing
- DP-SP may use either industrialized processing or lighter visual tooling within approved spoke boundaries
- DDC supports Redshift and S3 plus Apache Iceberg plus Athena as governed consumption patterns

## Typical Deliverables

Typical Data Architect deliverables include:

- end-to-end data-flow designs
- conceptual and logical data models
- entity and relationship definitions
- domain boundary and data ownership definitions
- business-rule mapping to platform data flows
- Data Contract definitions and interface expectations
- design notes for curated, conformed, and distributed data structures
- review guidance for engineering implementation alignment

## Key Decisions Owned by the Role

The Data Architect typically owns or strongly influences decisions such as:

- how business entities should be represented across the platform
- where data boundaries should exist between Ingestion, processing, and Distribution
- which Transformations represent business logic versus technical processing
- when a model should be standardized at enterprise level versus delegated to a spoke
- how shared datasets and spoke-owned datasets should interoperate
- how consumer-facing datasets should preserve meaning, traceability, and usability

These decisions should remain aligned with the Hub-and-Spoke Architecture and should be explicit enough for engineering teams to implement consistently.

## Boundaries

The Data Architect role does not primarily own:

- day-to-day pipeline implementation
- detailed Transformation code implementation
- deployment automation
- infrastructure provisioning
- operational monitoring setup
- execution of QA validation cycles
- backlog prioritization or delivery scheduling

The Data Architect should not replace the Data Engineer, Cloud DevOps, or Technical Product Owner roles. The role is accountable for design clarity and architectural coherence, not for absorbing implementation, release, or operations work.

## Collaboration Points

The Data Architect works closely with the following roles.

### Data Engineer

Collaboration focuses on:

- translating architecture into implementable pipelines
- validating that data flows reflect intended business rules
- reviewing Transformations against the target data model

### Data Platforms Architect

Collaboration focuses on:

- aligning data architecture with overall platform architecture
- maintaining consistency between component boundaries and data boundaries
- resolving hub-versus-spoke design decisions

### Cloud Architect

Collaboration focuses on:

- ensuring data designs are feasible within AWS-native service patterns
- understanding service-level constraints that affect modeling or flow choices

### Cloud DevOps

Collaboration focuses on:

- deployment implications of architectural design choices
- operational dependencies introduced by data-flow patterns

### Data QA Engineer

Collaboration focuses on:

- defining what should be validated from a data-semantics perspective
- ensuring tests reflect business-rule intent and modeled expectations

### Technical Product Owner

Collaboration focuses on:

- business prioritization of Data Domains and Data Products
- agreement on business meanings, rules, and delivery expectations

## Environment Applicability

The Data Architect designs for the full repository environment model:

- DIT
- DEV
- QA
- PPRD
- PRD

Environment applicability by component remains:

- ISC, DP-EH, DCS, and DDC follow DIT, DEV, QA, PPRD, PRD
- DP-SP follows DIT, DEV, PPRD, PRD

The Data Architect must account for these environment rules when defining promotion paths, validation expectations, and spoke-specific delivery patterns.

## Engineering and Modeling Expectations

Data Architect outputs in this repository should be:

- explicit about business meaning
- consistent in terminology
- aligned to end-to-end platform flow
- compatible with Metadata, Data Lineage, and governance expectations
- readable by architects, engineers, and product stakeholders
- generic enough for safe public reuse

The role should favor clarity over unnecessary abstraction and should avoid introducing organization-specific assumptions that are not suitable for a public template.

## Success Criteria

The Data Architect role is successful when:

- end-to-end data flows are coherent and understandable
- business rules are represented consistently in platform design
- data models are reusable and scalable across domains
- engineering teams can implement pipelines without ambiguity in design intent
- shared and spoke-specific patterns remain clearly separated
- published data structures are meaningful, governed, and fit for downstream use

## Relationship to Other Role Artifacts

This role is distinct from:

- the Data Engineer, who implements pipelines and Transformation logic
- the Data Platforms Architect, who defines broader platform architecture boundaries and component relationships

The Data Architect sits between business meaning and technical implementation, ensuring that the platform's data structures and flows remain deliberate, consistent, and fit for enterprise use.

## Out of Scope

This role definition does not prescribe:

- organization-specific governance bodies
- confidential business taxonomy
- a single mandatory modeling notation
- detailed implementation standards for code or infrastructure

Those concerns should be handled in supporting repository artifacts or downstream private adaptations.
