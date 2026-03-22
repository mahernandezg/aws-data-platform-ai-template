# DEV - Development

## Purpose

DEV is the core development environment of the Data Platform.

It exists to support active engineering work after early experimentation has been completed in DIT. In this repository, DEV is the environment where platform capabilities are built, integrated, and iteratively refined before they progress to structured validation and production-like readiness stages.

## Role in the Platform Lifecycle

DEV sits between DIT and the downstream validation environments.

Within the platform lifecycle, DEV is used to:

- build and refine architecture-aligned platform capabilities
- integrate component behavior across the Data Platform
- iteratively improve Ingestion, Transformation, Distribution, and Control Plane patterns
- execute pilot-grade workloads that are beyond proof-of-concept but not yet release-ready
- reduce technical uncertainty before formal validation or pre-production readiness assessment

DEV should be treated as the main engineering environment for implementation and iteration. It is not exploratory in the same way as DIT, and it is not yet a controlled validation stage like QA or PPRD.

## Scope of Usage

DEV applies to all architecture components in this repository:

- ISC
- DP-EH
- DP-SP
- DCS
- DDC

Why all components use DEV:

- ISC uses DEV to develop and integrate Ingestion behavior, source handling, and orchestration patterns.
- DP-EH uses DEV to refine Centralized Processing and shared Transformation capabilities.
- DP-SP uses DEV to build and iterate domain-aligned Distributed Processing and spoke-owned Data Product preparation.
- DCS uses DEV to evolve Control Plane capabilities, Metadata support, Data Governance controls, and Observability integrations.
- DDC uses DEV to develop governed Distribution behavior, access patterns, and downstream exposure structures.

DEV is therefore the shared engineering environment for both hub-oriented and spoke-oriented work.

## Account and Region Model

DEV is a controlled environment and therefore uses isolated AWS account boundaries.

The explicit component-aligned DEV account groups are:

- ISC-DEV
- DP-EH-DEV
- DP-SP-DEV
- DDC-DEV

DCS remains the shared control and governance layer across those account boundaries rather than being defined here as a separate component-owned DEV account family.

Region scope for DEV is:

- us-east-1
- eu-west-1

DEV is therefore a controlled multi-region environment, unlike the shared DIT sandbox model.

## Types of Workloads

Workloads expected in DEV are implementation-oriented and integration-aware.

Typical workload types include:

- active development of Ingestion workloads
- iterative Transformation development
- Data Product preparation and refinement
- component integration workloads
- pilot-grade Orchestration patterns
- Metadata and Data Lineage integration work
- governance-aligned access and distribution behavior under active change
- operational pattern refinement for Observability and supportability

Examples at high level include:

- refining an ISC ingestion path so it behaves consistently with DCS-supported controls
- developing a DP-EH shared processing flow that will later move into structured validation
- iterating a DP-SP domain workload before spoke release readiness is assessed in PPRD
- building a DDC access pattern that supports governed downstream use without yet claiming production readiness

## Data Characteristics

DEV should primarily use:

- test data
- synthetic data
- masked data
- controlled representative samples

Where needed, more realistic non-production datasets may be used to support integration and pilot activity, but the environment should not depend on unrestricted production data.

Stability expectations are moderate:

- data structures should be more stable than in DIT
- interfaces may still change as implementation evolves
- test datasets should be managed with enough consistency to support repeatable engineering work
- data behavior should be suitable for integration and iterative quality improvement

DEV data is not expected to have the stability required for production-like validation or operational use.

## Governance and Controls

DEV requires clear architectural and engineering discipline.

Expected controls in DEV include:

- explicit alignment with architecture component responsibilities
- explicit alignment with Medallion layer ownership where Landing Zone, Bronze, Silver, Gold, or DDC exposure behavior is involved
- traceable engineering changes and environment ownership
- stronger Metadata, Data Lineage, and Data Governance alignment than in DIT
- reviewable workload behavior suitable for structured team collaboration
- controlled promotion readiness criteria before work moves downstream

Approval expectations should be moderate. DEV is intended to support fast iteration, but not uncontrolled change. Work in DEV should already respect platform boundaries, shared governance expectations, and the separation between hub responsibilities and spoke responsibilities.

## Security Considerations

DEV is still a non-production environment, but it requires stronger security discipline than DIT.

Security expectations include:

- access limited to approved engineers, architects, quality, and platform operators as appropriate
- least-privilege access to workloads, datasets, and supporting services
- managed handling of secrets, credentials, and configuration
- avoidance of unnecessary exposure of sensitive data
- consistent application of DCS-supported access and governance controls

DEV should be open enough for active engineering, while remaining controlled enough to preserve trust in platform behavior and boundaries.

## Observability Expectations

DEV requires meaningful Observability because this is where platform behavior is actively shaped and integration issues must be diagnosed early.

Expected observability behavior includes:

- logging that supports debugging, workflow understanding, and integration analysis
- monitoring sufficient to identify failures, regressions, and unstable dependencies
- auditing of meaningful changes and execution behavior that affect platform evolution
- visibility into cross-component interactions where integration issues may emerge

Observability in DEV should be more disciplined than in DIT because engineering decisions made here influence later validation and release confidence.

## Stability and Reliability Expectations

DEV has medium stability expectations.

This means:

- active change is expected
- temporary failures are acceptable but should be investigated
- workloads should be reliable enough to support iterative engineering and integration
- repeated instability should be treated as a signal that the workload is not ready to progress

DEV does not need production-grade reliability, but it should be materially more stable than DIT because multiple roles depend on it for coordinated development work.

## Interaction with Other Environments

DEV is downstream of DIT and upstream of QA or PPRD, depending on the component.

Its role in the broader environment progression is:

- DIT feeds DEV when experimentation becomes structured engineering work
- DEV feeds QA for ISC, DP-EH, DCS, and DDC
- DEV feeds PPRD directly for DP-SP, because DP-SP does not use QA in this repository
- QA, where applicable, validates development outputs before pre-production readiness
- PPRD confirms production-like readiness before PRD

DEV is therefore the main transition point between early experimentation and controlled readiness validation.

## What This Environment Is NOT

DEV is not:

- an unconstrained sandbox
- a substitute for DIT experimentation
- a dedicated quality-validation environment
- a production-like readiness stage
- a stable operational environment for downstream consumers
- a place to bypass shared governance or architecture boundaries because work is still under development
- a place to blur DP-EH Gold, DP-SP Gold, or DDC Gold exposure boundaries during implementation
- a shared experimentation account pool

DEV must remain the active development and integration environment of the Data Platform, not a replacement for later validation stages.

## Summary

DEV is the active development environment of the Data Platform. It exists to support implementation, iteration, integration, and pilot-grade refinement across account-isolated multi-region component boundaries before workloads advance into structured validation and production-like readiness stages.
