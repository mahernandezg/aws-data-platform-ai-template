# Data Platforms Architect

## Purpose

This document defines the Data Platforms Architect role within the `aws-data-platform-ai-template`.

Its purpose is to clarify how the Data Platforms Architect owns the overall platform architecture direction for an AWS-native enterprise data platform built on the Hub-and-Spoke model used by this repository.

This role definition is intended to support:

- clear ownership of platform-level architecture decisions
- consistent application of Hub-and-Spoke boundaries across repository artifacts
- alignment between cloud architecture, data architecture, engineering delivery, and platform governance
- reusable public guidance for enterprise-grade data platform architecture

## Scope

The Data Platforms Architect role is responsible for defining and governing the architectural structure of the platform as a whole.

This includes:

- defining the responsibilities and boundaries of ISC, DP-EH, DP-SP, DCS, and DDC
- shaping how centralized and spoke-aligned capabilities should coexist
- guiding component interaction patterns across ingestion, processing, governance, and distribution
- ensuring that platform-level design decisions remain coherent across environments
- aligning architecture intent with AWS-native implementation possibilities and operational realities

The Data Platforms Architect does not primarily implement pipelines, provision infrastructure directly, or own detailed business-domain modeling.

## Mission

The mission of the Data Platforms Architect is to ensure that the platform evolves as a coherent, governable, and scalable system rather than as a collection of disconnected technical solutions.

The Data Platforms Architect should provide the architectural structure that allows cloud, data, engineering, DevOps, QA, and product roles to work with clear responsibilities and shared design intent.

## Architecture Alignment

The Data Platforms Architect is accountable for the platform-wide architecture model and its consistent interpretation across all major components.

### ISC

Within ISC, the Data Platforms Architect focuses on:

- defining the role of ingestion within the end-to-end platform
- clarifying where ingestion responsibilities stop and downstream responsibilities begin
- ensuring ISC patterns remain reusable, governed, and distinct from processing and distribution concerns

### DP-EH

Within DP-EH, the Data Platforms Architect focuses on:

- defining when capabilities belong in the enterprise hub
- shaping shared enterprise processing responsibilities
- ensuring hub capabilities do not become an uncontrolled catch-all for all workloads

### DP-SP

Within DP-SP, the Data Platforms Architect focuses on:

- defining the architectural purpose of spokes
- establishing the boundaries of spoke autonomy
- clarifying how spoke capabilities interact with shared platform services and enterprise governance

### DDC

Within DDC, the Data Platforms Architect focuses on:

- defining distribution as a governed platform capability
- shaping the relationship between processing outputs and downstream consumption
- preserving clear separation between internal processing concerns and consumer-facing access patterns

### DCS

Within DCS, the Data Platforms Architect focuses on:

- defining shared control-plane and foundational service responsibilities
- ensuring governance, metadata, observability, and access controls are treated as architectural concerns
- preventing duplication of foundational platform capabilities across other components

## Core Responsibilities

The Data Platforms Architect is expected to:

- define and maintain the platform architecture model for the repository
- establish clear component responsibilities and interaction boundaries
- decide when a capability should be centralized versus delegated to a spoke
- align cloud architecture, data architecture, and engineering patterns to a common platform direction
- guide architecture choices across ingestion, processing, governance, and distribution domains
- ensure repository artifacts use consistent terminology and architecture intent
- review proposed changes for consistency with the Hub-and-Spoke operating model
- identify architectural tradeoffs, risks, and unresolved boundary decisions
- document platform-level assumptions and rationale in a reusable way

## Typical Deliverables

Typical Data Platforms Architect deliverables include:

- platform architecture overviews
- component-boundary definitions
- hub-versus-spoke decision guidance
- platform design principles and architecture guardrails
- architecture review input for role, environment, and service-mapping documents
- architecture decision records or design notes when introduced
- guidance for reusable platform patterns and extension paths

## Key Decisions Owned by the Role

The Data Platforms Architect typically owns or strongly influences decisions such as:

- which responsibilities belong to ISC, DP-EH, DP-SP, DCS, and DDC
- when a capability should be centralized versus spoke-owned
- how component interactions should be structured across the platform
- how environment rules affect platform architecture boundaries
- how platform governance concerns should be embedded across the architecture
- how architecture terminology and definitions should be standardized in repository artifacts

These decisions should be clear enough for Cloud Architects, Data Architects, engineers, and DevOps teams to execute consistently.

## Boundaries

The Data Platforms Architect role does not primarily own:

- detailed AWS service implementation design
- detailed business-rule modeling
- direct pipeline development
- direct infrastructure deployment
- operational support execution
- backlog prioritization or product ownership

The Data Platforms Architect should not replace the Cloud Architect, Data Architect, Data Engineer, Cloud DevOps, Data QA Engineer, or Technical Product Owner roles. The role is accountable for platform architecture coherence, not for owning every detailed discipline beneath it.

## Collaboration Points

The Data Platforms Architect works closely with the following roles.

### Cloud Architect

Collaboration focuses on:

- translating platform architecture into AWS cloud architecture patterns
- ensuring component boundaries are realizable in cloud design

### Data Architect

Collaboration focuses on:

- aligning platform boundaries with end-to-end data flow and data model intent
- separating platform-level architecture from data semantics and domain modeling concerns

### Data Engineer

Collaboration focuses on:

- ensuring engineering implementations follow component responsibilities and approved architecture patterns

### Cloud DevOps

Collaboration focuses on:

- ensuring operational automation respects platform boundaries and environment rules
- validating that deployment models do not undermine architecture intent

### Data QA Engineer

Collaboration focuses on:

- clarifying architecture-driven validation expectations and quality boundaries

### Technical Product Owner

Collaboration focuses on:

- aligning platform architecture evolution with delivery priorities and product expectations

## Environment Applicability

The Data Platforms Architect designs for the full repository environment model:

- DIT
- DEV
- QA
- PPRD
- PRD

Environment applicability by component remains:

- ISC, DP-EH, DCS, and DDC follow DIT, DEV, QA, PPRD, PRD
- DP-SP follows DIT, DEV, PPRD, PRD

The Data Platforms Architect must ensure these environment rules are reflected consistently in architecture documents, component boundaries, and platform extension patterns.

## Architectural Expectations

Data Platforms Architect outputs in this repository should be:

- explicit about component purpose and boundaries
- consistent in terminology and structure
- aligned to Hub-and-Spoke governance and delivery principles
- compatible with AWS-native implementation paths
- practical for downstream engineering and architecture roles to apply
- generic enough for safe public-template reuse

The role should favor platform clarity over vague generalization and should avoid introducing organization-specific assumptions into the public repository core.

## Success Criteria

The Data Platforms Architect role is successful when:

- the platform architecture is understandable and consistently applied
- component responsibilities remain clear as the repository grows
- centralized and spoke-specific capabilities are intentionally separated
- cloud, data, engineering, and operational roles can work without architectural ambiguity
- repository artifacts reinforce one shared platform model rather than conflicting interpretations
- the public template remains reusable, structured, and enterprise-ready

## Relationship to Other Role Artifacts

This role is distinct from:

- the Cloud Architect, who focuses on AWS cloud foundation and service architecture
- the Data Architect, who focuses on end-to-end data flow, business rules, and data modeling
- the Data Engineer, who implements pipelines and transformations
- the Cloud DevOps role, which automates deployment and operations

The Data Platforms Architect defines the platform-level architecture frame that keeps these roles aligned around one coherent system design.

## Out of Scope

This role definition does not prescribe:

- organization-specific governance forums
- confidential enterprise operating structures
- one mandatory implementation stack for every workload
- detailed coding or deployment standards for every team

Those concerns should be handled in supporting repository artifacts or downstream private adaptations.
