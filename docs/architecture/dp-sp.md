# DP-SP - Data Processing Center - Spoke

## Purpose

DP-SP is the architecture component responsible for Distributed Processing in the Data Platform.

It exists to provide domain-aligned processing capability within the Hub-and-Spoke Architecture while preserving shared governance, Metadata, security, and operational standards. In this repository, DP-SP gives a Data Domain controlled autonomy for domain-specific Transformation and Data Product preparation without requiring all processing to be centralized in DP-EH.

## Responsibilities

- Execute Distributed Processing for domain-aligned use cases.
- Implement domain-specific Transformation logic within approved platform guardrails.
- Prepare spoke-owned Data Products for governed downstream Distribution.
- Apply domain-level processing behavior that does not require Centralized Processing ownership.
- Preserve alignment with shared Metadata, Data Governance, Data Quality, and Observability expectations.
- Support domain-specific processing sequences through approved Orchestration patterns.
- Maintain clear ownership boundaries between spoke processing and shared platform services.
- Publish governed outputs for downstream Data Distribution through DDC.

## Scope and Boundaries

DP-SP includes:

- domain-specific Transformation workloads
- spoke-owned processing logic and bounded business-context execution
- preparation of domain-aligned Data Products
- processing patterns that require local delivery autonomy within shared platform rules
- integration with shared platform services without duplicating them

DP-SP does not include:

- source-entry Ingestion responsibilities owned by ISC
- Centralized Processing owned by DP-EH
- Control Plane ownership owned by DCS
- primary consumer-facing Data Distribution ownership owned by DDC
- enterprise-wide reusable capabilities that justify centralization
- uncontrolled bypass of shared governance, Metadata, security, or observability standards

## Inbound Interactions

DP-SP receives data or control from:

- DDC, through governed access to data needed for domain-specific processing and downstream delivery
- DCS, which provides Control Plane capabilities such as access controls, Metadata services, governance rules, and operational standards
- domain-aligned engineering and orchestration processes that coordinate spoke processing activities

Nature of interactions:

- governed data is made available to DP-SP for Distributed Processing
- control signals, Metadata requirements, and policy boundaries are applied through DCS-supported capabilities
- orchestration coordinates execution timing, dependencies, and operational sequencing for spoke workloads

## Outbound Interactions

DP-SP sends data or control to:

- DDC, which receives spoke-owned outputs for governed Data Distribution and downstream consumption
- DCS, for Metadata registration, Data Lineage continuity, quality-control alignment, and Observability signals
- downstream support and governance processes that require visibility into spoke processing behavior

Purpose of interactions:

- publish domain-aligned outputs into governed downstream Distribution paths
- preserve traceability and control visibility for spoke processing activities
- ensure spoke-owned assets remain governable, discoverable, and operationally supportable

## Data and Control Responsibilities

### Data Plane Responsibilities

Within the Data Plane, DP-SP is responsible for:

- performing Distributed Processing for a defined Data Domain or spoke-aligned scope
- executing domain-specific Transformation logic
- producing spoke-owned outputs that support Data Products and downstream Distribution
- preserving processing traceability needed for Data Lineage

### Control Plane Responsibilities

DP-SP does not own the Control Plane, but it depends on and integrates with DCS-supported Control Plane capabilities.

Within that boundary, DP-SP is responsible for:

- applying shared governance and access requirements to spoke processing workloads
- using shared Metadata and lineage-supporting services consistently
- emitting operational signals required for Observability and auditability
- aligning spoke workflows to shared orchestration and control standards

## Environment Applicability

DP-SP applies to:

- DIT
- DEV
- PPRD
- PRD

Why these environments apply:

- DIT supports early validation of domain-specific processing logic and spoke integration assumptions
- DEV supports active engineering refinement of spoke workloads and local processing behavior
- PPRD supports final readiness validation under production-like conditions before production promotion
- PRD supports governed operational use of domain-aligned processing capabilities

DP-SP does not use QA in this repository. This reflects the repository environment model for spoke-aligned delivery and requires validation discipline to be achieved without a standalone shared QA stage.

## Typical AWS Services (High-Level)

Typical AWS services aligned to DP-SP include:

- AWS Glue
- dbt
- Apache Spark
- Amazon Athena
- Amazon S3
- Apache Iceberg
- AWS Step Functions

These services are indicative of common AWS-native or repository-aligned spoke processing patterns and should be interpreted at architecture level rather than as a mandatory implementation list.

## Governance and Security Considerations

- IAM boundaries must ensure that spoke teams and workloads can operate within approved domain scope without gaining uncontrolled access to shared platform assets.
- Access to spoke processing datasets must follow DCS-supported governance and security controls.
- Lake Formation may be relevant where spoke-owned assets participate in governed lake access, shared catalog structures, or controlled downstream use.
- DP-SP should apply least-privilege access to domain-aligned processing resources and intermediate assets.
- Spoke-owned outputs should remain governed and should not bypass DDC when downstream Distribution is required.
- Distributed Processing must preserve Metadata, Data Lineage, Data Quality, and Data Governance expectations even when delivery ownership is domain-aligned.

## Observability Considerations

- Logging should capture spoke workflow execution state, Transformation failures, retries, and processing boundary events.
- Monitoring should expose domain-level processing health, latency, throughput, and dependency issues without weakening platform-wide visibility.
- Auditing should support traceability of who changed or executed spoke processing behavior and how domain-owned outputs were produced.
- Operational signals from DP-SP should integrate with DCS-supported Observability capabilities so spoke workloads remain diagnosable and supportable across environments.

## Design Considerations

- Scalability: DP-SP should scale for domain-aligned delivery needs without requiring unnecessary centralization into DP-EH.
- Reusability: Spoke patterns should reuse shared platform conventions even when the business logic itself is domain-specific.
- Isolation: Domain-specific responsibilities should remain isolated from shared enterprise capabilities so local autonomy does not erode platform structure.
- Performance: Performance considerations are relevant where domain-level workload timing, data volume, or consumer expectations affect spoke delivery reliability.

## What This Component Is NOT

DP-SP is not:

- the component responsible for Ingestion
- the component responsible for Centralized Processing
- the platform Control Plane
- the governed Data Distribution layer
- a duplicate of shared enterprise services already provided by DCS or DP-EH
- an exception path that operates outside shared governance and platform standards

DP-SP must remain the spoke-aligned component for Distributed Processing and should only host capabilities that belong to a bounded domain context.

## Summary

DP-SP is the spoke-aligned processing component of the Data Platform. It exists to support domain-specific Transformation and Data Product preparation within shared platform guardrails so delivery autonomy can coexist with governance, Metadata consistency, and governed downstream Distribution.
