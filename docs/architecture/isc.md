# ISC - Ingestion Service Center

## Purpose

ISC is the architecture component responsible for Ingestion into the Data Platform.

It exists to bring data into the platform in a controlled, observable, and standardized manner before that data is used by downstream processing or governed distribution capabilities. In the Hub-and-Spoke Architecture used by this repository, ISC provides the managed entry point for upstream data sources and establishes the initial platform boundary for technical control, Metadata capture, and Ingestion discipline.

Within the repository's Medallion Data Architecture, ISC owns the Landing Zone only. It is responsible for raw data Ingestion and controlled handoff into downstream Bronze standardization, but it does not own Bronze, Silver, or Gold processing.

## Responsibilities

- Acquire data from upstream sources through approved Ingestion patterns.
- Standardize how source-aligned data enters the Data Platform.
- Apply ingestion-level controls before downstream platform use.
- Coordinate Ingestion through repeatable Orchestration patterns.
- Capture or integrate required Metadata for newly ingested assets.
- Support early Data Quality controls appropriate to platform entry.
- Preserve traceability needed for downstream Data Lineage.
- Handoff ingested data into governed downstream platform flows.
- Own the Landing Zone as the raw-entry layer of the Data Platform.

## Scope and Boundaries

ISC includes:

- source-to-platform Ingestion patterns
- Ingestion orchestration and technical control points
- initial landing or handoff behavior for incoming data
- ingestion-level validation and technical quality checks
- Metadata capture associated with data entering the platform
- operational handling of source-aligned Ingestion events
- Landing Zone responsibilities for raw data entry and handoff into Bronze processing

ISC does not include:

- Centralized Processing owned by DP-EH
- Distributed Processing owned by DP-SP
- Data Distribution owned by DDC
- shared Control Plane ownership owned by DCS
- broad consumer-facing access patterns
- enterprise-wide semantic modeling responsibilities
- Bronze, Silver, or Gold processing ownership

## Inbound Interactions

ISC receives data or control from:

- upstream source systems that provide files, events, records, or service-driven payloads for Ingestion
- DCS, which provides Control Plane capabilities such as access control, Metadata support, governance controls, and operational standards
- platform operators and engineering teams, which initiate or manage approved Ingestion flows through defined orchestration and operational processes

Nature of interactions:

- source data enters the Data Plane through controlled entry points
- control signals, access policies, and shared standards are applied through DCS-supported capabilities
- orchestration events or schedules trigger or coordinate Ingestion execution

## Outbound Interactions

ISC sends data or control to:

- DDC, as the primary governed downstream handoff defined by the repository interaction model
- DCS, for Metadata registration, observability signals, governance alignment, and operational traceability
- downstream platform support processes, through logs, metrics, events, and audit evidence needed for diagnosis and supportability

Purpose of interactions:

- move newly ingested data into governed downstream platform flows
- preserve Data Lineage and platform control visibility
- ensure downstream components can rely on consistent Ingestion behavior and managed handoff conditions

## Data and Control Responsibilities

### Data Plane Responsibilities

Within the Data Plane, ISC is responsible for:

- receiving source-aligned data into the platform
- performing controlled platform entry and handoff actions
- preserving traceability of how data first enters the Data Platform
- applying ingestion-level Data Quality checks needed before downstream use
- maintaining Landing Zone discipline without expanding into Bronze, Silver, or Gold processing ownership

### Control Plane Responsibilities

ISC does not own the Control Plane, but it depends on and integrates with DCS-supported Control Plane capabilities.

Within that boundary, ISC is responsible for:

- enforcing approved access and operational controls at the Ingestion boundary
- using shared Metadata and governance capabilities correctly
- emitting the operational signals required for Observability and auditability
- aligning Ingestion behavior with shared orchestration and governance standards

## Environment Applicability

ISC applies to:

- DIT
- DEV
- QA
- PPRD
- PRD

Why these environments apply:

- DIT supports early validation of source connectivity, ingestion patterns, and technical integration assumptions
- DEV supports active engineering refinement of Ingestion behavior and orchestration
- QA supports structured validation of Ingestion correctness, controls, and operational behavior before pre-production use
- PPRD supports final readiness validation under production-like conditions
- PRD supports governed operational Ingestion for real platform use

ISC uses the full shared environment model because Ingestion is a platform-entry concern that requires controlled progression from early experimentation through production operation.

## Typical AWS Services (High-Level)

Typical AWS services aligned to ISC include:

- Amazon S3
- AWS Glue
- AWS Glue Crawler
- AWS Glue API
- AWS Lambda
- AWS Step Functions
- Amazon EventBridge
- Amazon SQS
- Amazon MSK
- Apache Iceberg

These services are indicative of common AWS-native Ingestion patterns and should be interpreted at architecture level rather than as a mandatory implementation list. In Medallion terms, ISC supports Landing Zone entry and handoff. From Bronze onward, data remains aligned to the Apache Iceberg standard.

## Governance and Security Considerations

- IAM boundaries must ensure that only approved principals can initiate, manage, or access Ingestion paths.
- Access to source credentials, endpoints, and runtime configuration must follow DCS-supported security controls.
- Lake Formation may be relevant when ingested assets must align with governed catalog, access, or downstream lake access patterns.
- ISC should apply least-privilege access at the point where source data enters the platform.
- Ingestion boundaries must remain explicit so that source acquisition responsibilities do not expand into uncontrolled downstream data access.
- Metadata, Data Lineage, and Data Governance expectations must be established as data enters the Data Platform, not deferred until later stages.

## Observability Considerations

- Logging should capture Ingestion execution state, failures, retries, and boundary events without exposing confidential source details.
- Monitoring should make Ingestion throughput, latency, failure trends, and dependency issues visible to platform operators.
- Auditing should support traceability of who initiated or changed Ingestion behavior and how data entered the platform.
- Operational signals from ISC should integrate with DCS-supported Observability capabilities to support diagnosis and supportability across environments.

## Design Considerations

- Scalability: ISC should support multiple source-aligned Ingestion patterns without requiring each new source to redefine platform-entry controls.
- Reusability: Ingestion patterns should be standardized so new onboardings reuse established orchestration, Metadata, and control conventions.
- Isolation: Source-specific behavior should be bounded so one Ingestion path does not weaken governance or operational clarity for others.
- Performance: Performance considerations are relevant where ingestion throughput, event volume, or timing windows affect downstream platform readiness.

## What This Component Is NOT

ISC is not:

- the component responsible for Centralized Processing
- the component responsible for Distributed Processing
- the platform Control Plane
- the governed Data Distribution layer
- the primary owner of downstream consumer access patterns
- a generic place to place any data movement activity without regard to architecture boundaries
- the owner of Bronze, Silver, or Gold Transformation responsibilities

ISC must remain the controlled Ingestion boundary of the Data Platform and should not absorb responsibilities that belong to DP-EH, DP-SP, DCS, or DDC.

## Summary

ISC is the controlled Ingestion boundary of the Data Platform. It exists to bring data into the platform with consistent technical control, Metadata alignment, Observability, and governed handoff discipline so that downstream platform components can operate on a stable and traceable foundation.
