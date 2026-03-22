# Architecture Glossary

## Purpose

This glossary defines the controlled vocabulary for the `aws-data-platform-ai-template` repository.

It is the semantic reference for architecture documents, role definitions, prompts, templates, and future implementation artifacts. Terms in this glossary should be used consistently across the repository.

## Scope

This glossary covers:

- core architecture concepts
- named architecture components
- core data-platform concepts
- platform operating concepts
- environment terminology

This glossary does not define organization-specific operating models, confidential enterprise terms, or implementation-specific naming outside the scope of this public repository.

## Hub-and-Spoke Architecture

Definition:
A platform architecture model that separates shared enterprise capabilities from domain-aligned delivery capabilities while preserving common governance, Metadata, security, and operational standards.

Context in This Repository:
This repository uses Hub-and-Spoke Architecture as its primary platform model. The hub-side responsibilities are primarily represented by DCS, DP-EH, and governed aspects of DDC. The spoke-side responsibilities are represented by DP-SP. ISC and DDC connect ingestion and distribution to the broader platform.

Responsibilities / Role:
This concept defines how the repository structures platform responsibilities, component boundaries, and centralized-versus-distributed delivery patterns.

Relationships:
It connects directly to ISC, DP-EH, DP-SP, DCS, DDC, Centralized Processing, Distributed Processing, Data Domain, and Data Distribution.

Constraints (if applicable):
In this repository, Hub-and-Spoke Architecture must remain explicit and cannot be reduced to a generic multi-team platform model. Shared enterprise services and spoke-specific services must remain clearly separated.

## Data Platform

Definition:
A governed set of services, processes, standards, and operational capabilities used to ingest, process, manage, and distribute data across multiple teams and environments.

Context in This Repository:
The Data Platform is the complete system formed by ISC, DP-EH, DP-SP, DCS, and DDC, along with the environment model, governance expectations, and AWS-native operating patterns documented in this repository.

Responsibilities / Role:
It provides the structural foundation for ingestion, processing, metadata management, governance, data delivery, and operational support.

Relationships:
It contains all architecture components, all environment concepts, and all platform concepts defined in this glossary.

Constraints (if applicable):
In this repository, the Data Platform must be documented as a reusable public template and must not assume confidential enterprise processes or internal-only operating models.

## Landing Zone

Definition:
The initial platform entry layer where newly ingested source data is received before Medallion processing begins.

Context in This Repository:
In this repository, the Landing Zone belongs to ISC and is limited to raw data Ingestion behavior. It is the controlled point where source-aligned data first enters the Data Platform before Bronze standardization in DP-EH or DP-SP.

Responsibilities / Role:
It is responsible for receiving ingested source data, preserving source traceability, and supporting controlled handoff into downstream Medallion layers.

Relationships:
It connects directly to ISC, Ingestion, Metadata, Data Lineage, Bronze, DCS, and DDC.

Constraints (if applicable):
The Landing Zone is not a Medallion layer beyond platform entry. It must not be treated as a Transformation layer, a consumer-facing Distribution layer, or a substitute for Bronze standardization.

## Bronze

Definition:
The first Medallion layer in which ingested data is standardized into platform-managed structures while remaining close to source meaning and source granularity.

Context in This Repository:
Bronze is implemented in DP-EH or DP-SP after data enters through ISC. In DP-EH, Bronze supports enterprise-standardized raw structures. In DP-SP, Bronze supports domain-specific ingestion and standardization within shared platform governance. Bronze data must align with the Apache Iceberg standard.

Responsibilities / Role:
It is responsible for converting ingested data into governed, standardized raw structures suitable for downstream processing while preserving source traceability.

Relationships:
It connects directly to Landing Zone, Silver, DP-EH, DP-SP, Apache Iceberg-standardized data structures, Metadata, Data Lineage, and Data Quality.

Constraints (if applicable):
Bronze is not the Landing Zone and not a consumer-facing layer. It must not be treated as an ungoverned raw file area, and it must remain standardized according to repository platform rules.

## Silver

Definition:
The Medallion layer in which Bronze data is incrementally transformed into cleansed, structured, unified, and ACID-managed datasets suitable for reliable downstream modeling and reuse.

Context in This Repository:
In DP-EH, Silver represents enterprise-scale unified processing, including incremental processing and shared data structures such as SCD Type 2 patterns where relevant. In DP-SP, Silver represents domain-level Transformation within spoke ownership. Silver data must align with the Apache Iceberg standard.

Responsibilities / Role:
It is responsible for improving quality, consistency, structure, and reuse value beyond Bronze while preparing data for Gold Data Product modeling.

Relationships:
It connects directly to Bronze, Gold, DP-EH, DP-SP, Centralized Processing, Distributed Processing, Data Quality, Data Lineage, and Data Product preparation.

Constraints (if applicable):
Silver is not the consumer-serving layer. It must not be treated as final Distribution output, and its ownership must remain clear between enterprise-shared processing in DP-EH and domain-specific processing in DP-SP.

## Gold

Definition:
The Medallion layer in which processed data is modeled into final Data Product structures intended for governed downstream use.

Context in This Repository:
In DP-EH, Gold represents enterprise Data Products, including star-schema modeling, dimension and fact structures, and SCD Type 2 patterns where relevant. In DP-SP, Gold is limited to domain-specific Data Products or domain-specific enhancements of DP-EH Gold Data Products. DDC exposes Gold Data Products to consumers and does not own Gold processing. AI-oriented access may use Bronze, Silver, or Gold only as a controlled exception.

Responsibilities / Role:
It is responsible for producing governed final Data Product structures ready for Distribution and consumption.

Relationships:
It connects directly to Silver, Data Product, DP-EH, DP-SP, DDC, Distribution, Data Contract, and consumer-serving patterns.

Constraints (if applicable):
Gold must not create ambiguity between enterprise-wide canonical Data Products in DP-EH and domain-specific Gold outputs in DP-SP. DDC may expose Gold assets but must not become the processing owner of Gold. In the default platform pattern, DDC exposes Gold only to consumers, with AI-oriented access to Bronze, Silver, or Gold treated as an explicit controlled exception.

## Data Product

Definition:
A data asset or data-serving capability that is intentionally designed, governed, and maintained to satisfy a defined consumer need.

Context in This Repository:
Data Products are most commonly prepared in DP-EH or DP-SP and exposed through DDC using governed distribution patterns. They may be shared enterprise assets or domain-aligned outputs depending on ownership and scope.

Responsibilities / Role:
A Data Product is responsible for presenting usable, understandable, and supportable data to downstream consumers with clear semantics, ownership, and quality expectations.

Relationships:
It relates directly to Data Domain, Distribution, DDC, DP-EH, DP-SP, Data Contract, Data Quality, and Metadata.

Constraints (if applicable):
In this repository, a Data Product is not just a file, table, or pipeline output. It must imply managed intent, consumer relevance, and governed exposure.

## Data Domain

Definition:
A bounded area of business meaning and ownership used to organize data responsibilities, processing scope, and data-product accountability.

Context in This Repository:
Data Domains are especially relevant to DP-SP, where domain-aligned autonomy is expected within shared governance guardrails. Data Domains may also influence how shared assets are standardized in DP-EH.

Responsibilities / Role:
A Data Domain provides the boundary for business-context ownership, data semantics, and domain-specific transformation responsibilities.

Relationships:
It connects to DP-SP, Data Product, Distributed Processing, Data Contract, and Centralized Processing when domain assets must interoperate with shared enterprise capabilities.

Constraints (if applicable):
In this repository, a Data Domain must not bypass shared governance, Metadata, or distribution standards defined by DCS and DDC.

## Centralized Processing

Definition:
Processing capabilities that are designed, managed, and reused at enterprise scope rather than owned by a single domain.

Context in This Repository:
Centralized Processing is primarily represented by DP-EH, with support from DCS and governed interaction with DDC.

Responsibilities / Role:
It is responsible for reusable enterprise transformation patterns, cross-domain logic, shared processing services, and common standards that should not be reimplemented independently in every spoke.

Relationships:
It connects directly to DP-EH, DCS, DDC, Distributed Processing, Data Platform, and Hub-and-Spoke Architecture.

Constraints (if applicable):
Centralized Processing should not become an undefined catch-all for all workloads. Only capabilities with clear enterprise value, reuse, or governance need should be centralized.

## Distributed Processing

Definition:
Processing capabilities owned or executed in domain-aligned contexts rather than fully centralized enterprise layers.

Context in This Repository:
Distributed Processing is primarily represented by DP-SP, where spoke-aligned teams implement domain-specific transformations and data-product preparation.

Responsibilities / Role:
It is responsible for domain-specific transformation logic, local delivery needs, and bounded autonomy within shared platform guardrails.

Relationships:
It connects directly to DP-SP, Data Domain, Data Product, Centralized Processing, DDC, and Hub-and-Spoke Architecture.

Constraints (if applicable):
Distributed Processing must operate within shared governance, Metadata, security, and distribution boundaries. It is not a license to duplicate core platform services.

## Data Distribution

Definition:
The controlled exposure of data for downstream access, reuse, analytics, integration, or consumption.

Context in This Repository:
Data Distribution is treated as a first-class platform capability and is primarily represented by DDC. It is distinct from ingestion and transformation.

Responsibilities / Role:
It is responsible for making data available to consumers in a governed, traceable, and usable form.

Relationships:
It connects directly to DDC, Data Product, Distribution, DP-EH, DP-SP, Data Contract, Data Governance, and Metadata.

Constraints (if applicable):
In this repository, Data Distribution must remain governed. It must not be treated as an informal side effect of pipeline completion.

## ISC (Ingestion Service Center)

Definition:
The architecture component responsible for bringing data into the platform in a controlled, observable, and standardized manner.

Context in This Repository:
ISC is the repository’s ingestion entry point. It handles source-aligned onboarding and provides the platform handoff into downstream governed layers.

Responsibilities / Role:
ISC is responsible for ingestion orchestration, source connectivity patterns, ingestion controls, and initial landing or handoff behavior.

Relationships:
ISC connects to Ingestion, DCS, DDC, Metadata, Data Quality, Orchestration, and Observability.

Constraints (if applicable):
ISC is not the primary component for enterprise transformation or consumer-facing distribution. Its role is controlled entry, not broad downstream processing ownership.

## DP-EH (Enterprise Hub)

Definition:
The centralized enterprise processing component of the platform, used for shared and reusable data-processing capabilities.

Context in This Repository:
DP-EH provides the enterprise hub for common transformation patterns, shared data structures, and cross-domain processing needs.

Responsibilities / Role:
DP-EH is responsible for Centralized Processing, reusable enterprise logic, shared transformation services, and standard processing capabilities.

Relationships:
DP-EH connects to Centralized Processing, DCS, DDC, Data Product, Transformation, Metadata, Data Governance, and Data Quality.

Constraints (if applicable):
DP-EH should only contain capabilities that justify central ownership. It should not absorb spoke-specific workloads without a clear shared-platform reason.

## DP-SP (Spoke)

Definition:
The domain-aligned processing component of the platform, used for bounded local autonomy within shared enterprise governance.

Context in This Repository:
DP-SP represents spoke delivery capability for domain-specific processing, local business rules, and domain-oriented data products.

Responsibilities / Role:
DP-SP is responsible for Distributed Processing, domain-specific transformation logic, and spoke-owned delivery within approved platform standards.

Relationships:
DP-SP connects to Data Domain, Data Product, DDC, DCS, Transformation, Data Contract, and Distributed Processing.

Constraints (if applicable):
DP-SP does not use QA in this repository’s environment model. It must also avoid duplicating shared control-plane or enterprise-wide services already owned elsewhere.

## DCS (Data Core Services)

Definition:
The shared foundational service layer that provides control, governance, Metadata, access, and operational capabilities for the rest of the platform.

Context in This Repository:
DCS is the backbone of the platform. It enables consistency across ISC, DP-EH, DP-SP, and DDC.

Responsibilities / Role:
DCS is responsible for Control Plane capabilities such as metadata services, governance controls, access foundations, shared observability support, and common operational services.

Relationships:
DCS connects to Control Plane, Metadata, Data Governance, Observability, Orchestration, ISC, DP-EH, DP-SP, and DDC.

Constraints (if applicable):
DCS is not a business-data processing domain. Its role is foundational enablement and control, not ownership of domain logic or distribution outputs.

## DDC (Data Distribution Center)

Definition:
The governed distribution component of the platform that exposes data for downstream use and controlled consumer access.

Context in This Repository:
DDC is the repository’s dedicated distribution layer. It sits between internal platform processing and downstream data usage.

Responsibilities / Role:
DDC is responsible for Data Distribution, controlled publication, consumer-facing access patterns, and separation between internal processing and governed exposure.

Relationships:
DDC connects to Data Distribution, Data Product, DP-EH, DP-SP, ISC, DCS, Data Contract, Metadata, and Observability.

Constraints (if applicable):
DDC is not the primary place for ingestion onboarding or general-purpose transformation ownership. Its focus is governed exposure and downstream distribution.

## Ingestion

Definition:
The act of acquiring data from upstream sources and moving it into the platform under controlled technical and governance conditions.

Context in This Repository:
Ingestion is primarily handled by ISC and supported by DCS capabilities such as Metadata, access, and observability.

Responsibilities / Role:
Ingestion is responsible for controlled source onboarding, initial platform entry, and handoff into downstream platform flows.

Relationships:
It connects to ISC, Metadata, Data Quality, Observability, Orchestration, and Data Lineage.

Constraints (if applicable):
Ingestion does not imply full downstream transformation or data-product preparation. It is the platform entry function.

## Transformation

Definition:
The controlled reshaping, enrichment, standardization, or derivation of data after ingestion and before downstream use.

Context in This Repository:
Transformation occurs in DP-EH when it is shared and enterprise-oriented, and in DP-SP when it is domain-specific.

Responsibilities / Role:
Transformation is responsible for converting ingested data into usable structures aligned to enterprise or domain needs.

Relationships:
It connects to DP-EH, DP-SP, Data Product, Data Quality, Data Lineage, Metadata, Centralized Processing, and Distributed Processing.

Constraints (if applicable):
Transformation should not blur hub and spoke responsibilities. Shared logic and domain logic must remain intentionally separated.

## Distribution

Definition:
The act of making processed or governed data available to downstream consumers or systems.

Context in This Repository:
Distribution is primarily carried out through DDC after upstream ingestion and processing responsibilities have been fulfilled.

Responsibilities / Role:
Distribution is responsible for exposing data in controlled forms suitable for consumption, access management, and downstream reuse.

Relationships:
It connects to DDC, Data Distribution, Data Product, Data Contract, Metadata, and Observability.

Constraints (if applicable):
Distribution should not be confused with raw data movement or uncontrolled sharing. In this repository, it is always governed.

## Data Lineage

Definition:
The traceable record of how data moves, changes, and is used across the platform.

Context in This Repository:
Data Lineage is required to understand how data passes from ISC through processing layers and into DDC for downstream use.

Responsibilities / Role:
It is responsible for preserving transparency about source origin, transformation paths, ownership boundaries, and downstream exposure.

Relationships:
It connects to Ingestion, Transformation, Distribution, Metadata, Data Governance, Data Quality, ISC, DP-EH, DP-SP, and DDC.

Constraints (if applicable):
Data Lineage must be treated as a platform concern, not a documentation afterthought. It should support governance, supportability, and trust in data products.

## Data Governance

Definition:
The set of controls, rules, and management practices used to ensure data is handled consistently, securely, and accountably across the platform.

Context in This Repository:
Data Governance is embedded through DCS and influences every other component, especially ingestion, transformation, and distribution.

Responsibilities / Role:
It is responsible for enforcing consistent standards around access, Metadata, quality expectations, traceability, and controlled use of data assets.

Relationships:
It connects to DCS, Metadata, Data Quality, Data Contract, Data Lineage, Control Plane, and all architecture components.

Constraints (if applicable):
Data Governance in this repository must be architectural and practical. It must not be reduced to abstract policy language detached from platform behavior.

## Data Quality

Definition:
The degree to which data satisfies defined expectations for correctness, completeness, consistency, usability, and intended meaning.

Context in This Repository:
Data Quality is applied across ingestion, transformation, and distribution, with different controls and validation practices depending on the component and environment.

Responsibilities / Role:
It is responsible for ensuring data is fit for its intended platform and consumer use.

Relationships:
It connects to Ingestion, Transformation, Distribution, Data Product, Data Governance, Data Lineage, Metadata, and the Data QA Engineer role.

Constraints (if applicable):
Data Quality is not limited to technical schema validation. In this repository, it also includes semantic and operational fitness for downstream use.

## Metadata

Definition:
The descriptive information used to identify, classify, govern, locate, and understand data and related platform assets.

Context in This Repository:
Metadata is a core shared concern supported by DCS and used across ISC, DP-EH, DP-SP, and DDC.

Responsibilities / Role:
It is responsible for making data assets understandable, governable, discoverable, and traceable.

Relationships:
It connects to DCS, Data Governance, Data Lineage, Data Quality, Data Product, Data Contract, and all main architecture components.

Constraints (if applicable):
Metadata must be treated as a platform-wide managed capability. It should not be left to inconsistent local conventions across teams or components.

## Control Plane

Definition:
The set of shared services and controls used to govern, manage, configure, and observe the platform rather than to process business data itself.

Context in This Repository:
The Control Plane is primarily associated with DCS and includes governance, Metadata, access-control, and operational oversight capabilities.

Responsibilities / Role:
It is responsible for enabling consistent platform governance, management, and coordination across components.

Relationships:
It connects to DCS, Data Plane, Data Governance, Metadata, Observability, Orchestration, and all architecture components.

Constraints (if applicable):
The Control Plane must remain distinct from business-data processing responsibilities. Mixing control responsibilities into arbitrary processing layers weakens architecture clarity.

## Data Plane

Definition:
The part of the platform where business data is ingested, transformed, moved, and exposed for use.

Context in This Repository:
The Data Plane spans ISC, DP-EH, DP-SP, and DDC as they handle movement and use of actual data assets.

Responsibilities / Role:
It is responsible for the operational path of data through ingestion, processing, and distribution.

Relationships:
It connects to ISC, DP-EH, DP-SP, DDC, Control Plane, Ingestion, Transformation, and Distribution.

Constraints (if applicable):
The Data Plane must remain governed by DCS-supported controls. It is not an unmanaged flow layer independent of platform governance.

## Orchestration

Definition:
The coordination of ordered steps, dependencies, and execution logic across data-platform activities.

Context in This Repository:
Orchestration is used across ingestion, processing, and distribution to manage workflows, dependencies, and operational execution paths.

Responsibilities / Role:
It is responsible for sequencing work, coordinating execution, and making platform flows operationally manageable.

Relationships:
It connects to ISC, DP-EH, DP-SP, DDC, DCS, Ingestion, Transformation, Distribution, Observability, and Control Plane.

Constraints (if applicable):
Orchestration is not a substitute for architecture design. It coordinates workflows but does not define component responsibility boundaries by itself.

## Observability

Definition:
The ability to understand platform behavior through operational signals such as logs, metrics, traces, events, and audit evidence.

Context in This Repository:
Observability is a cross-cutting platform concern supported through DCS and required across all architecture components and environments.

Responsibilities / Role:
It is responsible for supporting monitoring, diagnosis, supportability, auditability, and operational trust.

Relationships:
It connects to DCS, Control Plane, Ingestion, Transformation, Distribution, Data Lineage, Data Quality, and the Data Platforms Operations role.

Constraints (if applicable):
Observability must be designed into the platform. It cannot be treated as an optional operational enhancement added only after incidents occur.

## Data Contract

Definition:
A defined agreement about the structure, meaning, and expected use conditions of a data interface between producers and consumers.

Context in This Repository:
Data Contracts are especially important where DP-SP, DP-EH, and DDC interact, and wherever data products or shared datasets cross ownership boundaries.

Responsibilities / Role:
It is responsible for reducing ambiguity in schema, semantics, ownership expectations, and downstream usage conditions.

Relationships:
It connects to Data Product, Data Domain, DP-EH, DP-SP, DDC, Metadata, Data Quality, and Distribution.

Constraints (if applicable):
In this repository, a Data Contract should not be reduced to a schema-only artifact. It must also support meaning, boundary clarity, and governed interoperability.

## DIT

Definition:
The sandbox environment used for early experimentation, controlled technical trials, and initial validation of platform changes.

Context in This Repository:
DIT is the earliest environment in the repository model and is used by ISC, DP-EH, DP-SP, DCS, and DDC.

Responsibilities / Role:
It is responsible for supporting low-risk experimentation and early engineering feedback before changes move into more structured development flows.

Relationships:
It connects to DEV, the broader environment model, and all architecture components.

Constraints (if applicable):
DIT is not a substitute for later validation stages. It supports early iteration, not release confidence by itself.

## DEV

Definition:
The development environment used to build, integrate, and iteratively refine platform capabilities under active engineering change.

Context in This Repository:
DEV is used by all major architecture components and serves as the core engineering environment after DIT.

Responsibilities / Role:
It is responsible for enabling active development, technical integration, and structured progression toward validation stages.

Relationships:
It connects to DIT, QA, PPRD, PRD, and all architecture components.

Constraints (if applicable):
DEV should not be treated as the final validation stage for production readiness.

## QA

Definition:
The quality-assurance environment used to validate behavior, integration, and release confidence for components that require a dedicated QA stage.

Context in This Repository:
QA applies to ISC, DP-EH, DCS, and DDC. It does not apply to DP-SP.

Responsibilities / Role:
It is responsible for structured quality validation before changes progress to pre-production and production-like use.

Relationships:
It connects to DEV, PPRD, Data Quality, and the components that use the shared QA stage.

Constraints (if applicable):
DP-SP does not use QA in this repository. QA must therefore not be described as universally applicable across all architecture components.

## PPRD

Definition:
The pre-production environment used to validate release readiness under conditions that closely resemble production expectations.

Context in This Repository:
PPRD is used by all architecture components, including DP-SP.

Responsibilities / Role:
It is responsible for final readiness checks, controlled pre-release validation, and confirmation that changes can safely progress toward production.

Relationships:
It connects to DEV, QA where applicable, PRD, and all architecture components.

Constraints (if applicable):
PPRD is not an exploratory environment. It should be treated as a controlled stage for near-production validation.

## PRD

Definition:
The production environment where platform capabilities operate for real governed use and downstream consumption.

Context in This Repository:
PRD is the final environment in the model and applies to all architecture components.

Responsibilities / Role:
It is responsible for delivering stable, governed, and supportable platform behavior for operational use.

Relationships:
It connects to PPRD, Observability, Data Distribution, Data Product, and all architecture components.

Constraints (if applicable):
PRD changes must reflect the repository’s environment discipline and should only follow controlled progression from earlier environments.
