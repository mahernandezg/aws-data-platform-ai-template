# QA - Quality Assurance

## Purpose

QA is the structured quality-validation environment of the Data Platform.

It exists to verify that shared platform capabilities behave correctly, integrate as intended, and meet release-confidence expectations before they move into production-like validation in PPRD. In this repository, QA is the environment where development outputs are assessed for correctness, quality, and readiness, rather than actively shaped through ongoing implementation.

## Role in the Platform Lifecycle

QA sits downstream of DEV and upstream of PPRD.

Within the platform lifecycle, QA is used to:

- validate behavior that was developed and integrated in DEV
- test cross-component correctness for shared platform capabilities
- assess Data Quality, control behavior, and operational fitness before pre-production validation
- confirm that platform changes are stable enough to justify progression toward production-like conditions
- provide structured evidence that development outputs are ready for the next stage

QA should be treated as a validation and testing environment, not as an extension of active development. Its purpose is to reduce uncertainty before PPRD, not to serve as a general-purpose engineering workspace.

## Scope of Usage

QA applies only to the following architecture components in this repository:

- ISC
- DP-EH
- DCS
- DDC

QA does not apply to:

- DP-SP

Why QA applies only to shared platform components:

- ISC uses QA to validate Ingestion behavior, source handling, and handoff quality before production-like readiness.
- DP-EH uses QA to validate Centralized Processing, shared Transformation behavior, and reusable enterprise processing patterns.
- DCS uses QA to validate Control Plane behavior, Metadata support, governance controls, and shared operational capabilities.
- DDC uses QA to validate governed Distribution behavior, downstream access patterns, and consumer-facing distribution correctness.

DP-SP does not use QA in this repository. Spoke-aligned workloads progress from DEV to PPRD without a standalone QA stage. QA must therefore not be described as a universal environment across all architecture components.

## Types of Workloads

Workloads expected in QA are validation-oriented rather than implementation-oriented.

Typical workload types include:

- structured validation of Ingestion paths
- testing of shared Transformation logic
- verification of Data Product outputs prepared through shared components
- assessment of Metadata, Data Lineage, and Data Governance behavior
- validation of Control Plane integrations and access behavior
- testing of governed Distribution and downstream access conditions
- operational and observability verification for shared services

Examples at high level include:

- verifying that an ISC ingestion flow handles expected and invalid inputs correctly
- testing that a DP-EH shared processing flow produces consistent outputs across expected scenarios
- validating that DCS-supported controls enforce the intended governance and access boundaries
- checking that a DDC distribution path exposes data correctly under governed conditions

## Data Characteristics

QA should primarily use:

- test data
- synthetic data
- masked data
- controlled representative datasets

Data used in QA should be stable enough to support repeatable validation and comparable results across test runs.

Stability expectations are higher than in DEV:

- schemas should be relatively controlled
- datasets should be managed to support reproducible validation outcomes
- interfaces under test should not be changing continuously during execution of quality-validation activities
- data conditions should support both positive and negative test scenarios

QA data should remain non-production in nature unless specifically governed and justified for validation purposes.

## Governance and Controls

QA requires stronger governance and control than DIT or DEV because it is used to support release-confidence decisions.

Expected controls in QA include:

- clearly defined scope of what is being validated
- traceable validation activity and outcome recording
- controlled change entry so testing is performed on identifiable versions of shared platform capabilities
- explicit Data Governance, Metadata, and Data Quality expectations
- alignment between validation scope and downstream promotion readiness

Approval expectations should be stronger than in DEV. QA is a controlled environment for validation, and changes entering it should already be sufficiently mature to justify structured testing.

## Security Considerations

QA is still a non-production environment, but it should maintain disciplined security controls because it influences release-confidence decisions and may use more representative datasets than early environments.

Security expectations include:

- access limited to approved engineering, quality, architecture, DevOps, and operational roles as appropriate
- least-privilege access to validation datasets, services, and control mechanisms
- managed handling of credentials, secrets, and test configurations
- controlled treatment of any masked or representative data used for validation
- consistent enforcement of DCS-supported access and governance controls

QA should remain secure enough to support credible validation without being treated as a relaxed testing sandbox.

## Observability Expectations

QA requires strong Observability because failures in this environment must be diagnosable, attributable, and actionable before promotion to PPRD.

Expected observability behavior includes:

- logging that supports defect analysis, workflow verification, and traceability
- monitoring of validation outcomes, failures, regressions, and dependency issues
- auditing of changes, test execution, and relevant access or control events
- visibility into cross-component behavior where shared services interact

Observability in QA should be more rigorous than in DEV because QA outcomes influence release readiness for shared platform capabilities.

## Stability and Reliability Expectations

QA has medium-to-high stability expectations.

This means:

- active feature development should not dominate the environment
- temporary failures may occur, but they should be treated as quality signals rather than expected background noise
- workloads should be stable enough to support repeatable testing and reliable comparison of results
- instability that prevents meaningful validation should block progression to PPRD

QA does not need to be fully production-like, but it must be stable enough to provide trustworthy validation outcomes.

## Interaction with Other Environments

QA is downstream of DEV and upstream of PPRD for the components that use it.

Its role in the broader environment progression is:

- DIT supports experimentation
- DEV supports active development and integration
- QA validates shared platform outputs from DEV
- PPRD validates production-like readiness after QA
- PRD hosts stable governed operational workloads

Promotion into QA should occur when shared platform work is ready for structured validation. Promotion out of QA should occur only when testing and quality assessment support progression to PPRD.

For DP-SP, this QA stage does not exist. Spoke-aligned workloads move from DEV directly to PPRD under a different validation lifecycle.

## What This Environment Is NOT

QA is not:

- a sandbox for experimentation
- the main environment for active feature implementation
- a spoke environment for DP-SP
- a substitute for PPRD production-like validation
- a place to perform uncontrolled design changes during testing
- a final operational environment for downstream consumers

QA must remain the structured validation environment for shared platform capabilities, with its component scope explicitly limited to ISC, DP-EH, DCS, and DDC.

## Summary

QA is the structured quality-assurance environment of the Data Platform. It exists to validate shared platform capabilities across ISC, DP-EH, DCS, and DDC before they progress to PPRD, while explicitly excluding DP-SP from its scope in accordance with the repository environment model.
