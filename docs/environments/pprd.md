# PPRD - Pre Production

## Purpose

PPRD is the production-like validation environment of the Data Platform.

It exists to confirm that platform capabilities are ready for governed operational use in PRD under conditions that closely resemble production expectations. In this repository, PPRD is the final readiness stage where architecture-aligned workloads, controls, and interactions are validated as near-production behavior rather than as development or testing activity.

## Role in the Platform Lifecycle

PPRD sits immediately upstream of PRD.

Within the platform lifecycle, PPRD is used to:

- validate release readiness under production-like conditions
- confirm that component interactions behave correctly at near-production quality
- verify that governance, security, Observability, and operational expectations are in place
- assess whether workloads are stable enough for governed operational use
- provide final architectural and operational confidence before promotion to PRD

PPRD should be treated as a controlled readiness environment. It is not a place for open-ended experimentation or routine feature development. Its purpose is to prove that a platform change is ready to become operational.

## Scope of Usage

PPRD applies to all architecture components in this repository:

- ISC
- DP-EH
- DP-SP
- DCS
- DDC

Why all components use PPRD:

- ISC uses PPRD to validate near-production Ingestion behavior and source-entry reliability.
- DP-EH uses PPRD to validate Centralized Processing readiness for shared enterprise workloads.
- DP-SP uses PPRD as its final pre-production validation stage because DP-SP does not use QA.
- DCS uses PPRD to validate Control Plane readiness, governance controls, Metadata support, and operational consistency.
- DDC uses PPRD to validate governed Distribution behavior and consumer-facing access readiness under production-like conditions.

PPRD is therefore the common final readiness environment across both hub-oriented and spoke-oriented components.

## Types of Workloads

Workloads expected in PPRD are production-like validation workloads rather than exploratory or implementation-oriented workloads.

Typical workload types include:

- pre-production Ingestion validation
- near-production Transformation and processing validation
- final Data Product readiness verification
- end-to-end cross-component path validation
- Control Plane readiness assessment
- governed Distribution verification under production-like access patterns
- operational support and Observability validation
- release-candidate workload execution

Examples at high level include:

- confirming that an ISC ingestion path behaves correctly under expected operational conditions
- verifying that a DP-EH shared processing flow is stable enough for production promotion
- validating that a DP-SP spoke workload is ready for operational use without a separate QA stage
- checking that DDC exposes distributed assets correctly with production-like governance and access controls

## Data Characteristics

PPRD should use data conditions that are as close to PRD as practical while remaining appropriately controlled.

Typical data characteristics include:

- masked data
- highly representative test data
- controlled production-like datasets
- stable datasets suitable for repeatable readiness assessment

Data in PPRD should reflect realistic structure, scale, and behavior closely enough to support credible validation of production readiness.

Stability expectations are high:

- schemas should be controlled
- datasets should support repeatable readiness checks
- interfaces should be materially stable
- test conditions should approximate PRD usage patterns closely enough to reveal meaningful issues before production promotion

PPRD data should not be treated casually or reset in the same way as early environments.

## Governance and Controls

PPRD requires strong governance and control because it directly supports the decision to promote workloads into PRD.

Expected controls in PPRD include:

- explicit release-readiness scope
- strong alignment with architecture component boundaries
- strong alignment with Medallion layer ownership and DDC Gold exposure rules
- controlled entry of changes and release candidates
- clear Data Governance, Data Quality, Metadata, and Data Lineage expectations
- traceable evidence of readiness assessment
- limited tolerance for uncontrolled environment change during validation

Approval expectations should be high. PPRD is a controlled stage where work should already be mature, reviewable, and close to operational readiness.

## Security Considerations

PPRD should be treated as a high-control non-production environment with security expectations close to PRD.

Security expectations include:

- tightly controlled access limited to approved roles with legitimate readiness and operational responsibilities
- least-privilege access to workloads, data assets, and control mechanisms
- secure handling of secrets, credentials, and configuration
- strong enforcement of DCS-supported access boundaries and governance controls
- careful treatment of representative or masked data used for production-like validation

PPRD should preserve a security posture that supports confident transition into PRD without introducing unnecessary differences in access behavior.

## Observability Expectations

PPRD requires strong Observability with expectations close to PRD.

Expected observability behavior includes:

- comprehensive logging needed for release-readiness diagnosis
- monitoring sufficient to assess operational health, dependency behavior, and near-production reliability
- auditing of change activity, access, and readiness-relevant execution events
- visibility across cross-component interactions and operational control behavior

Observability in PPRD should be rigorous enough to reveal issues that would matter in PRD, not merely enough to support development debugging.

## Stability and Reliability Expectations

PPRD has high stability expectations.

This means:

- uncontrolled change should be minimized
- failures should be treated as significant readiness concerns
- workloads should be stable enough to behave credibly under production-like conditions
- repeated instability should block promotion to PRD

PPRD does not need to carry the full business criticality of PRD, but it should be stable enough that successful outcomes provide meaningful confidence in production readiness.

## Interaction with Other Environments

PPRD is downstream of DEV and QA where applicable, and upstream of PRD.

Its role in the broader environment progression is:

- DIT supports experimentation
- DEV supports active implementation and integration
- QA validates shared platform components before pre-production readiness
- DP-SP moves from DEV directly to PPRD because DP-SP does not use QA
- PPRD validates production-like readiness for all components
- PRD receives only workloads that have demonstrated readiness in PPRD

PPRD is therefore the convergence point where both shared platform capabilities and spoke-aligned capabilities undergo final readiness assessment before operational use.

## What This Environment Is NOT

PPRD is not:

- a sandbox for experimentation
- the main environment for feature development
- a substitute for QA where QA applies
- the production environment itself
- a place to accept unresolved architectural ambiguity
- a casual staging area without strong governance and readiness discipline
- a place to carry unresolved Medallion ownership ambiguity into PRD

PPRD must remain the controlled production-like validation environment of the Data Platform, distinct from both earlier testing environments and PRD operational use.

## Summary

PPRD is the production-like validation environment of the Data Platform. It exists to provide final readiness confirmation across ISC, DP-EH, DP-SP, DCS, and DDC so that only stable, governed, and operationally credible workloads progress into PRD.
