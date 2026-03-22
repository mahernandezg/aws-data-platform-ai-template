# DCS - Data Core Services

## Purpose

DCS is the architecture component responsible for the shared foundational service layer of the Data Platform.

It exists to provide the Control Plane capabilities required for the rest of the Hub-and-Spoke Architecture to operate consistently, securely, and governably. In this repository, DCS is the shared backbone that enables Metadata management, Data Governance, access control, Observability, and operational coordination across ISC, DP-EH, DP-SP, and DDC.

## Responsibilities

- Provide shared Control Plane capabilities for the Data Platform.
- Establish and support common Metadata services and standards.
- Enable Data Governance controls across all architecture components.
- Provide shared access-control and security-supporting capabilities.
- Support Observability, auditability, and operational visibility across the platform.
- Enable common orchestration-supporting services and operational coordination patterns.
- Preserve consistency of foundational controls across Hub and Spoke components.
- Prevent duplication of foundational services in ISC, DP-EH, DP-SP, and DDC.

## Scope and Boundaries

DCS includes:

- shared Control Plane capabilities
- Metadata and governance-supporting services
- access-control and security-supporting platform services
- common observability and audit-supporting services
- shared operational and orchestration-supporting capabilities
- foundational services required by multiple architecture components

DCS does not include:

- source-entry Ingestion responsibilities owned by ISC
- Centralized Processing owned by DP-EH
- Distributed Processing owned by DP-SP
- primary consumer-facing Data Distribution owned by DDC
- domain-specific business logic
- direct ownership of business-data processing outcomes

## Inbound Interactions

DCS receives data or control from:

- ISC, DP-EH, DP-SP, and DDC, which depend on DCS for shared Control Plane capabilities
- platform architecture, engineering, DevOps, quality, and operations processes that apply or consume shared controls and service standards
- operational signals emitted by platform components for centralized visibility, governance alignment, and supportability

Nature of interactions:

- platform components consume shared controls, Metadata capabilities, and operational services
- governance and access requirements are coordinated through DCS-supported services
- logs, events, metrics, and audit-relevant signals are integrated to support platform-wide visibility

## Outbound Interactions

DCS sends data or control to:

- ISC, to support controlled Ingestion with shared Metadata, governance, access, and Observability capabilities
- DP-EH, to support Centralized Processing with shared controls and service standards
- DP-SP, to support Distributed Processing within shared platform guardrails
- DDC, to support governed Data Distribution with shared access, Metadata, and observability capabilities

Purpose of interactions:

- provide Control Plane capabilities required by all main architecture components
- enforce shared governance and security expectations across the Data Platform
- preserve consistent Metadata, operational visibility, and supportability across Hub and Spoke responsibilities

## Data and Control Responsibilities

### Data Plane Responsibilities

DCS is not a primary Data Plane component.

Within platform behavior, DCS may support Data Plane activities indirectly by:

- enabling Metadata visibility for Data Plane assets
- enforcing governance and access rules around data movement and use
- providing shared operational services needed by Data Plane components

DCS does not own Ingestion, Transformation, or Distribution as business-data processing functions.

### Control Plane Responsibilities

Within the Control Plane, DCS is responsible for:

- providing common services used to govern and manage the Data Platform
- supporting Metadata registration, discoverability, and consistency
- enabling shared access-control and security-supporting services
- supporting Observability, auditability, and operational coordination
- preserving shared governance and control standards across all architecture components

## Environment Applicability

DCS applies to:

- DIT
- DEV
- QA
- PPRD
- PRD

Why these environments apply:

- DIT supports early validation of foundational controls, Metadata behaviors, and shared service integration
- DEV supports active development and refinement of shared platform services
- QA supports structured validation of governance, security, and shared control behavior
- PPRD supports final readiness validation of Control Plane capabilities under production-like conditions
- PRD supports governed operational use of foundational platform services

DCS uses the full shared environment model because the Control Plane must remain consistent and supportable across the entire platform lifecycle.

## Typical AWS Services (High-Level)

Typical AWS services aligned to DCS include:

- AWS IAM
- AWS Lake Formation
- AWS Secrets Manager
- AWS CloudWatch
- AWS CloudTrail
- Dynatrace
- Amazon EventBridge

These services are indicative of common AWS-native foundational capabilities and should be interpreted at architecture level rather than as a mandatory implementation list.

## Governance and Security Considerations

- IAM is a core concern of DCS because access boundaries must be applied consistently across all platform components.
- Lake Formation may be relevant where governed data-access controls, metadata-aligned permissions, or shared lake governance patterns are required.
- Access boundaries must distinguish clearly between shared platform capabilities and business-data processing responsibilities.
- DCS should apply least-privilege principles to shared control services and administrative capabilities.
- Governance controls supported by DCS must be reusable, explicit, and consistently applied across Hub and Spoke components.
- DCS must not weaken architectural separation by collapsing all security or governance decisions into informal local conventions.

## Observability Considerations

- Logging should support platform-wide visibility into shared control behavior, service health, access events, and governance-relevant actions.
- Monitoring should expose foundational service health, dependency issues, control-plane reliability, and operational exceptions affecting multiple components.
- Auditing should preserve traceability of access changes, governance actions, and control-related platform events.
- Observability signals supported by DCS should make it possible to diagnose issues that cross component boundaries rather than remain isolated within one workload.

## Design Considerations

- Scalability: DCS should scale as shared platform demand grows without requiring each component to recreate foundational services independently.
- Reusability: DCS capabilities should be reusable across ISC, DP-EH, DP-SP, and DDC so governance and control patterns remain consistent.
- Isolation: Foundational controls should remain isolated from business-data processing responsibilities so the Control Plane remains distinct from the Data Plane.
- Performance: Performance considerations are relevant where Control Plane latency or service contention affects orchestration, access decisions, or operational visibility across multiple platform components.

## What This Component Is NOT

DCS is not:

- the component responsible for Ingestion
- the component responsible for Centralized Processing
- the component responsible for Distributed Processing
- the governed Data Distribution layer
- a business-domain processing area
- a generic shared-services label for unrelated platform capabilities without clear control or foundational purpose

DCS must remain the shared foundational and Control Plane layer of the Data Platform and should not absorb business-data processing responsibilities that belong elsewhere.

## Summary

DCS is the shared foundational service layer of the Data Platform. It exists to provide the Control Plane capabilities that make Hub and Spoke components governable, observable, secure, and operationally consistent without turning foundational services into a business-data processing domain.
