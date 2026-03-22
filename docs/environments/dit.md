# DIT - Sandbox

## Purpose

DIT is the earliest environment in the Data Platform lifecycle.

It exists to support sandbox-oriented experimentation, proof-of-concept work, and early validation of architecture-aligned ideas before those ideas enter more structured development and validation stages. In this repository, DIT provides a controlled place to explore platform patterns without treating exploratory work as production-ready capability.

## Role in the Platform Lifecycle

DIT sits at the beginning of the progression from experimentation to governed operational use.

Within that lifecycle, DIT is used to:

- test early architecture assumptions
- explore service combinations and workload patterns
- validate initial component interactions
- trial Ingestion, Transformation, Distribution, and Control Plane concepts at low risk
- prove that a proposed direction is technically feasible before deeper engineering investment

DIT should be treated as a learning and shaping environment. It helps reduce uncertainty before work moves into DEV, where active iterative development becomes the primary concern.

## Scope of Usage

DIT applies to all architecture components in this repository:

- ISC
- DP-EH
- DP-SP
- DCS
- DDC

Why all components use DIT:

- ISC uses DIT to explore source-entry patterns and early Ingestion behavior.
- DP-EH uses DIT to assess Centralized Processing concepts and shared Transformation patterns.
- DP-SP uses DIT to explore domain-aligned processing ideas before spoke delivery matures.
- DCS uses DIT to validate foundational Control Plane assumptions, Metadata support, and governance-supporting capabilities.
- DDC uses DIT to trial governed Distribution patterns and controlled downstream exposure concepts.

DIT is therefore a platform-wide exploratory environment, not a component-specific exception space.

## Types of Workloads

Workloads expected in DIT are exploratory and architecture-shaping rather than release-oriented.

Typical workload types include:

- proof-of-concept Ingestion flows
- early Transformation experiments
- sandbox Data Product prototypes
- Metadata and Data Lineage validation exercises
- Control Plane capability trials
- Orchestration experiments
- Observability pattern trials
- limited end-to-end path demonstrations across components

Examples at high level include:

- testing whether a proposed ISC ingestion pattern can enter the Data Platform correctly
- validating whether a DP-EH shared Transformation approach is reusable
- exploring whether a DP-SP domain workload can remain inside shared governance boundaries
- assessing whether a DDC Distribution pattern supports the intended downstream access model

## Data Characteristics

DIT should preferentially use:

- synthetic data
- test data
- masked data
- minimal representative samples

Data used in DIT should be suitable for experimentation and low-risk validation.

Stability expectations are intentionally low:

- schemas may change frequently
- test datasets may be reset or replaced
- data completeness may be intentionally partial
- interfaces may be revised as architectural understanding improves

DIT is not intended for stable consumer-facing datasets or authoritative production-aligned data assets.

## Governance and Controls

DIT still operates inside the Data Platform and therefore requires governance, but the level of strictness is lighter than in later environments.

Expected controls in DIT include:

- basic alignment with architecture boundaries
- explicit identification of the component being explored
- controlled use of Metadata where relevant
- traceability of experiments that influence future design decisions
- access controls appropriate to exploratory workloads

Approval expectations should remain lightweight and practical. DIT is meant to enable learning, not create unnecessary procedural friction. Even so, experimentation in DIT must not bypass core architectural rules or ignore shared control expectations defined by DCS.

## Security Considerations

DIT should be treated as a lower-sensitivity environment than PPRD or PRD, but not as an uncontrolled sandbox.

Security expectations include:

- access must still be restricted to approved engineering and platform users
- least-privilege principles should still be applied
- secrets and credentials must remain managed through approved secure mechanisms
- sensitive or production-identifiable data should be avoided unless properly protected and justified

DIT should allow experimentation without weakening the security posture expected of a public, enterprise-grade Data Platform foundation.

## Observability Expectations

DIT requires Observability, but the level of strictness is oriented toward learning and diagnosis rather than full operational rigor.

Expected observability behavior includes:

- logging sufficient to understand workload behavior and failures
- monitoring of major execution outcomes and technical issues
- audit visibility for changes that materially affect platform direction
- traceability of early experiments that may later become reusable patterns

Observability in DIT should be strong enough to support debugging and architectural learning, even if alerting and operational coverage are lighter than in later environments.

## Stability and Reliability Expectations

DIT has low stability expectations.

This means:

- failure tolerance is relatively high
- temporary breakage is acceptable during exploration
- interfaces may be incomplete or unstable
- workloads may be short-lived or intentionally disposable

Reliability still matters when an experiment is being evaluated, but DIT is not expected to provide the consistency required from DEV, QA, PPRD, or PRD.

## Interaction with Other Environments

DIT is upstream of DEV.

Its role in the broader environment progression is:

- DIT supports early experimentation and feasibility validation
- DEV receives work that has moved beyond exploratory uncertainty
- QA, where applicable, validates more structured readiness after development
- PPRD validates production-like readiness
- PRD hosts stable governed operational workloads

Promotion from DIT should occur only when an idea or pattern has enough clarity to justify structured engineering work. DIT should inform later environments, not replace them.

## What This Environment Is NOT

DIT is not:

- the main environment for active feature completion
- a substitute for DEV
- a release-readiness environment
- a production-like validation stage
- a place to host stable downstream consumer workloads
- an excuse to ignore Data Governance, security, Metadata, or architecture boundaries

DIT must remain an exploratory environment with architectural discipline, not a permanent holding area for unfinished platform capabilities.

## Summary

DIT is the sandbox environment of the Data Platform. It exists to support controlled experimentation, proof-of-concept work, and early architectural validation across ISC, DP-EH, DP-SP, DCS, and DDC before work advances into more structured development and governed lifecycle stages.
