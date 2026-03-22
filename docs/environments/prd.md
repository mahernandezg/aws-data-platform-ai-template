# PRD - Production

## Purpose

PRD is the governed operational environment of the Data Platform.

It exists to run platform capabilities for real use, real downstream consumption, and sustained operational support. In this repository, PRD is the final environment in the lifecycle and represents the point where Ingestion, Centralized Processing, Distributed Processing, Control Plane capabilities, and Data Distribution operate as stable production services rather than as pre-release candidates.

## Role in the Platform Lifecycle

PRD sits at the end of the progression from DIT through PPRD.

Within the platform lifecycle, PRD is used to:

- operate platform workloads for real governed use
- deliver stable Data Products and Data Distribution outcomes
- support ongoing Ingestion, Transformation, Distribution, and Control Plane behavior under operational conditions
- provide durable service to downstream consumers and platform stakeholders
- preserve trust in platform stability, governance, security, and supportability

PRD should be treated as the environment of operational truth. It is not a place to validate whether a change might work. It is the environment where approved and production-ready capabilities must work reliably.

## Scope of Usage

PRD applies to all architecture components in this repository:

- ISC
- DP-EH
- DP-SP
- DCS
- DDC

Why all components use PRD:

- ISC uses PRD to perform governed operational Ingestion from upstream sources.
- DP-EH uses PRD to run Centralized Processing and shared enterprise processing capabilities.
- DP-SP uses PRD to operate domain-aligned Distributed Processing and spoke-owned delivery responsibilities.
- DCS uses PRD to provide live Control Plane capabilities such as governance, Metadata support, access control, and Observability support.
- DDC uses PRD to expose governed Data Distribution and consumer-facing access patterns for real downstream use.

PRD is therefore the operational convergence point for both hub-oriented and spoke-oriented responsibilities in the Data Platform.

## Types of Workloads

Workloads expected in PRD are stable operational workloads.

Typical workload types include:

- operational Ingestion workloads
- production Transformation and processing workloads
- governed Data Product publication and maintenance
- Control Plane operations that support live platform governance and access behavior
- consumer-facing Distribution workloads
- operational Observability and support functions
- scheduled, event-driven, or continuously running platform services that support real business use

Examples at high level include:

- running ISC ingestion flows that bring real source data into the Data Platform
- operating DP-EH shared processing workloads used across multiple consumers or domains
- running DP-SP spoke-owned processing that supports domain-aligned operational outcomes
- exposing DDC distributed assets to downstream consumers under governed access conditions

## Data Characteristics

PRD uses real governed operational data.

Typical data characteristics include:

- production data
- governed live datasets
- durable operational records
- production-grade Data Products and distributed assets

Stability expectations are very high:

- schemas should be intentionally managed
- interfaces should be controlled and dependable
- datasets should support real operational use and downstream trust
- data handling must preserve Data Governance, Data Quality, Metadata, and Data Lineage expectations

PRD data is not disposable, experimental, or casually replaceable. It represents live platform value and operational accountability.

## Governance and Controls

PRD requires the strongest governance and control level in the environment model.

Expected controls in PRD include:

- strict adherence to architecture component responsibilities
- controlled promotion from earlier environments, especially PPRD
- strong Data Governance and Data Quality enforcement
- explicit Metadata and Data Lineage management
- tightly managed operational change discipline
- clear accountability for access, execution behavior, and downstream impact

Approval expectations should be highest in PRD. Changes reaching PRD should already have demonstrated readiness in earlier environments and should be introduced with strong control and review discipline.

## Security Considerations

PRD is the highest-sensitivity environment in the platform lifecycle.

Security expectations include:

- tightly controlled access limited to approved operational, engineering, governance, and support roles
- strong least-privilege enforcement across workloads, users, and services
- secure handling of secrets, credentials, and configuration with no informal workarounds
- rigorous enforcement of DCS-supported access boundaries and governance controls
- careful protection of real data, live interfaces, and operational service behavior

PRD security should reflect the fact that it protects real data, real consumers, and real platform trust.

## Observability Expectations

PRD requires the highest Observability standard in the environment model.

Expected observability behavior includes:

- comprehensive logging for operational diagnosis and auditability
- monitoring that supports service health visibility, incident detection, and operational continuity
- auditing of access, configuration changes, governance-relevant actions, and workload behavior
- clear visibility into cross-component dependencies and downstream effects

Observability in PRD must support real operational support, incident analysis, compliance-aligned traceability, and ongoing confidence in platform behavior.

## Stability and Reliability Expectations

PRD has the highest stability and reliability expectations.

This means:

- failures should be treated as operational incidents, not normal background behavior
- uncontrolled change is unacceptable
- workloads should be dependable enough to support real downstream use
- resilience, supportability, and predictability are required platform qualities

PRD must provide stable service across ISC, DP-EH, DP-SP, DCS, and DDC because it is the environment where the Data Platform delivers operational value.

## Interaction with Other Environments

PRD is downstream of PPRD and has no further promotion target in the environment model.

Its role in the broader environment progression is:

- DIT supports experimentation
- DEV supports active implementation and integration
- QA validates shared platform components where applicable
- PPRD validates production-like readiness for all components
- PRD receives only workloads that are ready for live governed use

PRD should not be used to compensate for unresolved issues from earlier environments. It depends on the discipline of upstream environments and, in turn, becomes the reference point for operational trust and live platform behavior.

## What This Environment Is NOT

PRD is not:

- a sandbox for experimentation
- a development environment
- a testing or quality-validation environment
- a production-like simulation stage
- a place to introduce unresolved architectural or operational ambiguity
- an environment where changes can be treated as low-risk

PRD must remain the stable governed operational environment of the Data Platform and should only host capabilities that are ready for real use.

## Summary

PRD is the production environment of the Data Platform. It exists to operate stable, governed, and supportable workloads across ISC, DP-EH, DP-SP, DCS, and DDC so the platform can deliver real operational value, trusted Data Products, and controlled Data Distribution to downstream consumers.
