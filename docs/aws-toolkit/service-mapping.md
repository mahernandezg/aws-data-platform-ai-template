# AWS Service Mapping

## Purpose

This document connects architecture intent to the AWS and engineering services used in the `aws-data-platform-ai-template`.

Its purpose is to explain which services fit which architecture responsibilities, why they fit, and where their boundaries are. The goal is not to list product features. The goal is to help architects and engineers translate the Hub-and-Spoke Architecture into a coherent, reusable, and governed implementation direction.

## How to Read This Document

This document is architectural guidance, not a rigid one-to-one prescription for every workload. Different implementations may choose different services within the approved patterns described here.

Two platform standards are not optional:

- AWS IAM access must use IAM Roles only. IAM Users are not used in this platform.
- Apache Iceberg is the mandatory Open Table Format standard from ISC onward across the Data Platform.

Everything else in this document should be read as architecture-aligned selection guidance within those hard constraints.

The repository also enforces Medallion Data Architecture responsibilities:

- ISC owns the Landing Zone only
- DP-EH owns enterprise Bronze, Silver, and Gold processing
- DP-SP owns spoke Bronze and Silver processing, plus constrained Gold ownership for domain-specific outputs or enhancements of DP-EH Gold assets
- DDC exposes Gold Data Products to consumers, with AI-oriented access to Bronze, Silver, or Gold treated as a controlled exception

## Mapping Principles

- Service selection must start from architecture responsibility, not from product preference.
- Shared foundational concerns belong in DCS and should not be duplicated in every component.
- Hub responsibilities and Spoke responsibilities must remain clearly separated.
- Medallion layer ownership must remain explicit from Landing Zone through Gold.
- Data access must be governed through role-based access and shared control services.
- Observability must be designed as a platform concern, not added only after incidents.
- IAM Roles are mandatory across the platform, including automation, runtime execution, and operational access.
- Apache Iceberg is the mandatory table standard from ISC onward and must remain consistent across DP-EH, DP-SP, and DDC.

## Platform Standards

### IAM Standard

The Data Platform uses AWS IAM Roles only.

- IAM Users are not used in the platform.
- Access must be role-based.
- Roles must be assumable by approved workloads, services, automation mechanisms, and human operators where applicable.
- Runtime services, orchestration services, and deployment automation must execute through IAM Roles.
- Access boundaries should be enforced through DCS-aligned governance patterns, not through user-centric credential distribution.

This standard exists to preserve strong governance, least-privilege access, operational traceability, and reusable enterprise-grade security patterns.

### Data Format Standard

Apache Iceberg is the standard Open Table Format across the entire Data Platform.

- From ISC onward, all data must be landed and standardized in Apache Iceberg.
- Apache Iceberg is the default and required table format across ISC, DP-EH, DP-SP, and DDC.
- Hive-style unmanaged tables or alternative table formats must not be treated as the default platform pattern.
- Metadata, Data Lineage, and downstream access design should assume Iceberg consistency across the Data Platform.

This standard exists to provide a consistent governed table model with ACID behavior, schema evolution support, partition evolution flexibility, and strong interoperability across processing and consumption services.

### Medallion Layer Standard

The Data Platform uses a mandatory Medallion layer model.

- ISC owns the Landing Zone and raw data Ingestion only.
- DP-EH owns enterprise Bronze, Silver, and Gold processing.
- DP-SP owns spoke Bronze and Silver processing, plus Gold only for domain-specific Data Products or domain-specific enhancements of DP-EH Gold outputs.
- DDC exposes Gold Data Products to consumers.
- AI-oriented access to Bronze, Silver, or Gold is allowed only as a controlled exception.

This standard exists to keep Landing Zone, Bronze, Silver, Gold, processing ownership, and Distribution responsibilities explicit across the platform.

### Data Product Consumption Pattern

Data Products may be consumed through two primary patterns in DDC:

- Amazon Redshift as a serving and read-performance optimization layer for high-performance structured consumption and BI-oriented workloads
- Amazon S3 plus Apache Iceberg plus Amazon Athena as a serverless consumption pattern

Redshift standard:

- Amazon Redshift is used only to store and serve final Data Products.
- Amazon Redshift is not a processing engine for the Data Platform.
- Amazon Redshift is not the default engine for massive-scale Transformation or heavy batch processing.
- Redshift usage is limited to databases, schemas, tables, views, materialized views, and optimizations that improve read performance.

Athena and Iceberg standard:

- Not all Data Products require Amazon Redshift.
- Amazon S3 plus Apache Iceberg plus Amazon Athena is a valid consumption pattern in DDC.
- This applies when a hub or spoke does not provision a Redshift cluster, when the Data Product does not justify a dedicated cluster, or when serverless analytics is the better fit.
- Iceberg remains the standard format even when Athena is the consumption engine.

### Amazon Redshift Deployment Pattern

Amazon Redshift usage depends on component role.

Producer and consumer Redshift patterns do not change architecture ownership boundaries:

- data remains owned in its origin component, such as ISC, DP-EH, or DP-SP
- governed sharing should be managed through DCS-aligned controls, with AWS Lake Formation as the standard shared-governance mechanism where applicable
- final consumer-facing serving through Redshift belongs in DDC, not in the producing processing component

For DP-EH and DP-SP:

- Redshift may be used as producer clusters.
- Producer clusters may be none, one, or many.
- The decision depends on hub or spoke strategy and on whether producer-side structures are needed before governed sharing.
- Producer clusters do not replace DDC as the controlled Data Distribution layer.
- Producer clusters should be treated as source-serving structures that share governed data outward rather than as the final consumer-serving layer.

For DDC:

- Redshift is used as consumer clusters.
- Consumer clusters may be one or many.
- The decision depends on Distribution and consumption strategy, especially where read performance and consumer-facing query optimization are required.
- Where producer and consumer Redshift patterns coexist, the DDC consumer cluster is the final serving layer and should receive governed shared access from producer-side assets through AWS Lake Formation-aligned sharing controls.

This pattern does not change the core rule that Redshift is not the primary platform for massive-scale processing.

### SageMaker Unified Studio Usage Model

SageMaker Unified Studio may be used in:

- DP-EH
- DP-SP
- DDC

In DP-EH and DP-SP, it may be used for:

- data exploration
- feature engineering
- ML experimentation
- model development

In DDC, it is limited to:

- data catalog exploration
- data profiling
- data discovery
- data subscription workflows

In DDC, it must not be used for:

- data processing
- large-scale Transformations
- Data Product generation

Data processing remains a responsibility of DP-EH or DP-SP. DDC remains a Distribution and interaction layer, not a processing layer.

## Service Categories

### Ingestion

Typical services:

- AWS Glue
- AWS Glue Crawler
- AWS Glue API
- AWS Glue Zero-ETL integrations
- Amazon MSK
- Amazon SQS
- Amazon EventBridge
- AWS Lambda
- AWS Database Migration Service (AWS DMS)

Medallion alignment:

- supports the Landing Zone in ISC
- supports raw-entry controls before Bronze standardization

### Processing

Typical services:

- Apache Spark
- PySpark
- SparkSQL
- AWS Glue jobs system
- DBT
- Amazon EMR
- AWS Glue Studio

Medallion alignment:

- supports Bronze, Silver, and Gold processing ownership in DP-EH
- supports Bronze, Silver, and constrained Gold processing in DP-SP

### Storage

Typical services:

- Amazon S3
- Apache Iceberg

Medallion alignment:

- supports Landing Zone handoff and all Medallion layers
- preserves Apache Iceberg as the standard format from Bronze onward

### Metadata and Governance

Typical services:

- AWS Glue Data Catalog
- AWS Lake Formation
- AWS Glue Data Quality

### Orchestration

Typical services:

- AWS Step Functions
- Apache Airflow
- Amazon EventBridge

### Observability

Typical services:

- Amazon CloudWatch
- AWS CloudTrail
- Dynatrace

### Security

Typical services:

- AWS IAM
- AWS Secrets Manager

### Analytics and Consumption

Typical services:

- Amazon Athena
- Amazon Redshift
- JDBC endpoints for Athena and Redshift

Medallion alignment:

- supports Gold exposure in DDC
- supports AI-oriented access to Bronze, Silver, or Gold only as a controlled exception

### AI Services

Typical services:

- SageMaker Unified Studio
- Amazon Bedrock
- Amazon Q

## Component-to-Service Mapping

## ISC - Ingestion Service Center

Component purpose:
ISC is responsible for Ingestion into the Data Platform and for controlled platform entry.

Service categories used:

- ingestion
- storage
- orchestration
- metadata and governance
- observability

Recommended services:

- Amazon S3
- Apache Iceberg
- AWS Glue
- AWS Glue Crawler
- AWS Glue API
- AWS Glue Zero-ETL integrations
- Amazon EventBridge
- Amazon SQS
- Amazon MSK
- AWS Lambda
- AWS Step Functions
- AWS Glue Data Catalog
- AWS Glue Data Quality
- AWS Database Migration Service (AWS DMS)

Why they fit:

- ISC needs controlled ingestion patterns for batch, event, and service-driven entry.
- S3 provides the storage foundation for landed data.
- Apache Iceberg is mandatory from ISC onward, so ingestion outputs must be standardized in Iceberg rather than left in ad hoc table formats.
- Glue services support ingestion jobs, schema discovery, and metadata alignment.
- Event-driven services support controlled orchestration at the ingestion boundary.
- In Medallion terms, ISC owns the Landing Zone and hands data into downstream Bronze standardization.

Boundaries:

- ISC is not the place for broad enterprise Transformation ownership.
- ISC is not the place for consumer-facing Distribution.
- ISC should not treat non-Iceberg landing structures as the default platform pattern.
- ISC should not introduce IAM User-based access. Runtime access must use IAM Roles.
- ISC does not own Bronze, Silver, or Gold processing.

## DP-EH - Data Processing Center - Enterprise Hub

Component purpose:
DP-EH is responsible for Centralized Processing and shared enterprise Transformation capabilities.

Service categories used:

- processing
- storage
- orchestration
- metadata and governance
- observability
- analytics and consumption
- AI services

Recommended services:

- Apache Spark
- PySpark
- SparkSQL
- AWS Glue
- AWS Glue jobs system
- DBT
- Amazon EMR
- AWS Step Functions
- Apache Airflow
- Amazon S3
- Apache Iceberg
- AWS Glue Data Catalog
- AWS Glue Data Quality
- Amazon Redshift
- SageMaker Unified Studio

Why they fit:

- DP-EH is the primary enterprise-scale processing zone for massive volumes of data.
- Spark, Glue, and dbt are the preferred processing standards for large-scale Transformation and industrialized data workflows.
- S3 plus Iceberg provides the storage and table foundation for shared enterprise processing.
- Redshift may be used as a producer cluster when producer-side serving structures are required before governed sharing, but not as the main heavy-processing engine and not as a substitute for DDC consumer serving.
- SageMaker Unified Studio fits exploration, feature engineering, ML experimentation, and model development in the hub.
- In Medallion terms, DP-EH owns enterprise Bronze, Silver, and Gold processing.

Boundaries:

- DP-EH is not the primary consumer-facing Distribution layer.
- DP-EH should not rely on Redshift as the default massive-scale processing engine.
- DP-EH should not treat producer-side Redshift structures as the final consumer-serving layer.
- DP-EH should not produce non-Iceberg default tables from shared processing flows.
- DP-EH should not duplicate DCS governance responsibilities.
- DP-EH Gold ownership must remain distinct from spoke-specific Gold ownership in DP-SP.

## DP-SP - Data Processing Center - Spoke

Component purpose:
DP-SP is responsible for Distributed Processing in domain-aligned contexts.

Service categories used:

- processing
- storage
- orchestration
- metadata and governance
- observability
- analytics and consumption
- AI services

Recommended services:

- Apache Spark
- PySpark
- SparkSQL
- AWS Glue
- DBT
- AWS Glue Studio
- AWS Step Functions
- Amazon S3
- Apache Iceberg
- AWS Glue Data Catalog
- AWS Glue Data Quality
- Amazon Redshift
- SageMaker Unified Studio

Why they fit:

- DP-SP may use the same industrialized frameworks as DP-EH when a spoke needs scalable engineering depth.
- DP-SP may also use lighter visual tooling such as Glue Studio where that better matches spoke autonomy and local delivery needs, provided the resulting data still conforms to the mandatory Apache Iceberg standard.
- S3 plus Iceberg remains the mandatory storage and table standard.
- Redshift may be used as a producer cluster when spoke strategy requires producer-side serving structures before governed sharing, but it is not the default engine for heavy batch processing and not the final consumer-serving layer.
- SageMaker Unified Studio fits spoke-side exploration, feature engineering, ML experimentation, and model development.
- In Medallion terms, DP-SP owns spoke Bronze and Silver processing and Gold only where the output remains domain-specific or enhances DP-EH Gold.

Boundaries:

- DP-SP is not the place to duplicate shared Control Plane services.
- DP-SP should not bypass DCS governance or DDC distribution principles.
- DP-SP should not treat producer-side Redshift structures as the final consumer-serving layer.
- DP-SP should not treat visual tools as an excuse to abandon Iceberg standardization.
- DP-SP does not use QA in the environment model, so validation patterns must be designed accordingly.
- DP-SP must not define enterprise-wide canonical Gold Data Products.

## DCS - Data Core Services

Component purpose:
DCS provides shared Control Plane capabilities across the Data Platform.

Service categories used:

- security
- metadata and governance
- observability
- orchestration
- infrastructure support

Recommended services:

- AWS IAM
- AWS Lake Formation
- AWS Secrets Manager
- AWS Glue Data Catalog
- Amazon CloudWatch
- AWS CloudTrail
- Dynatrace
- Amazon EventBridge
- Terraform
- AWS CLI

Why they fit:

- DCS owns foundational governance, access, Metadata, and observability capabilities.
- IAM provides role-based access control and must operate through IAM Roles only.
- Lake Formation supports governed data access patterns aligned to shared controls.
- Secrets Manager supports secure runtime configuration without embedded secrets.
- CloudWatch, CloudTrail, and Dynatrace support platform-wide Observability and auditability.
- Terraform and the AWS CLI fit shared infrastructure and operational management patterns.

Boundaries:

- DCS is not a business-data processing domain.
- DCS must not use IAM Users as a platform access model.
- DCS should not host spoke-specific business logic or heavy data Transformation workloads.

## DDC - Data Distribution Center

Component purpose:
DDC is responsible for Data Distribution and consumer-facing governed access.

Service categories used:

- storage
- analytics and consumption
- metadata and governance
- observability
- AI services

Recommended services:

- Amazon S3
- Apache Iceberg
- Amazon Athena
- Amazon Redshift
- JDBC endpoints for Athena and Redshift
- AWS Glue Data Catalog
- AWS Lake Formation
- SageMaker Unified Studio

Why they fit:

- DDC needs governed exposure of Data Products and controlled downstream access.
- S3 is the storage foundation for exposed Data Products.
- Iceberg remains the standard table format for distributed assets.
- Athena is a valid serverless consumption engine over Iceberg datasets when flexible serverless access is sufficient.
- Redshift is a valid consumer-cluster serving layer where high-performance structured consumption, BI workloads, query performance, and read optimization justify it.
- Where producer and consumer Redshift patterns coexist, DDC is the place where consumer-serving Redshift access should be exposed.
- SageMaker Unified Studio fits discovery, profiling, catalog exploration, and subscription workflows in DDC, but not processing.
- In Medallion terms, DDC exposes Gold Data Products to consumers and may permit AI-oriented access to Bronze, Silver, or Gold only as a controlled exception.

Boundaries:

- DDC is not the primary large-scale processing layer.
- DDC must not use SageMaker Unified Studio for Data Product generation or large-scale Transformation.
- DDC supports both Redshift consumer clusters and S3 plus Iceberg plus Athena serverless consumption patterns.
- DDC should not position Redshift as a processing engine or as the default processing engine.
- DDC should not expose consumer-facing assets outside role-based access and shared governance controls.
- DDC must not become the owner of Bronze, Silver, or Gold processing.

## Cross-Cutting Core Services Mapping

### AWS IAM

- IAM Roles only are permitted.
- IAM Users are not used in the platform.
- Workload execution, automation, and operational access must be role-based and assumable.
- IAM governance should be centralized through DCS.

### AWS Lake Formation

- Lake Formation supports governed data access and policy enforcement.
- It should be treated as a DCS-governed service that reinforces controlled access to Iceberg-backed data assets.
- It is also the standard governance mechanism for sharing data outward from origin components toward DDC consumer-serving patterns where applicable.

### AWS Secrets Manager

- Secrets Manager is the standard mechanism for runtime secrets and secure configuration.
- It supports role-based retrieval and avoids embedded credentials.

### Amazon CloudWatch

- CloudWatch supports logs, metrics, and operational visibility across components and environments.
- It is part of the platform Observability baseline.

### AWS CloudTrail

- CloudTrail supports auditability for access and change events.
- It is required for governance-aligned traceability across the platform.

### Dynatrace

- Dynatrace complements AWS-native observability with cross-service operational visibility where required.
- It is a shared observability capability, not a component-specific product choice.

### Terraform

- Terraform supports repeatable infrastructure definition and environment-consistent deployment patterns.
- It should align with DCS governance and with role-based access standards.

### Amazon EventBridge

- EventBridge supports event-driven orchestration and component coordination.
- It is relevant both to ingestion triggering and to cross-cutting orchestration patterns.

## Environment Considerations

DIT:

- supports early experimentation
- may use a reduced subset of services
- must still preserve IAM Role usage and Apache Iceberg standardization where data is landed from ISC onward

DEV:

- supports active implementation and integration
- should align more fully with target platform service patterns
- must preserve Iceberg consistency across evolving workloads

QA:

- applies to ISC, DP-EH, DCS, and DDC only
- does not apply to DP-SP
- should validate service integration, governance, and quality behavior against the shared architecture

PPRD:

- applies to all components
- should validate production-like service behavior and operational controls
- should preserve the same Iceberg-centered table strategy used in earlier environments

PRD:

- applies to all components
- hosts stable operational workloads
- must fully enforce IAM Roles only, Iceberg standardization, and governed access behavior

Across all environments:

- Apache Iceberg remains the standard table format from ISC onward
- IAM Roles remain the only valid access model
- DP-SP excludes QA and moves from DEV to PPRD
- Medallion layer responsibilities remain stable across environments: Landing Zone in ISC, enterprise Bronze/Silver/Gold in DP-EH, spoke Bronze/Silver and constrained Gold in DP-SP, and Gold exposure in DDC by default

## Design Guidance and Trade-Offs

### AWS Glue vs Amazon EMR and Spark

- AWS Glue is preferred when managed serverless processing, tight catalog integration, and lower operational overhead are the priority.
- Amazon EMR with Spark is appropriate when workload control, scale tuning, or specialized Spark behavior requires more flexibility.
- In DP-EH, Spark, Glue, and dbt should be the preferred stack for large-scale Transformation and processing workloads.
- In DP-SP, the same stack may be used, but some spokes may prefer lighter options when domain scale and autonomy justify them.

### AWS Lambda vs AWS Step Functions

- Lambda fits focused stateless execution steps and event-driven utility logic.
- Step Functions fits multi-step orchestration, explicit state management, and governed execution sequencing.
- Orchestration should not be hidden inside scattered Lambda logic when process visibility matters.

### Amazon Athena vs Amazon Redshift

- Athena is a strong fit for flexible, serverless consumption over S3 and Iceberg-backed Data Products.
- Athena is appropriate when the Data Product does not justify a dedicated cluster or when serverless access is sufficient for the consumption pattern.
- Redshift is a strong fit for high-performance structured consumption, BI workloads, final serving structures, and curated delivery patterns that need read optimization.
- Redshift should be positioned as a serving and consumption optimization layer, not as a processing engine and not as the main engine for heavy large-scale data processing.
- If producer-side Redshift structures exist in DP-EH or DP-SP, they should feed governed sharing patterns rather than replace DDC as the final consumer-serving layer.
- In the default Medallion consumption pattern, DDC exposes Gold only. Access to Bronze or Silver should be reserved for controlled AI-oriented exceptions rather than general downstream consumption.

### When to Avoid Amazon Redshift

- Avoid Redshift when the Data Product does not justify a dedicated cluster.
- Avoid Redshift when S3 plus Iceberg plus Athena provides sufficient serverless access for the expected consumers.
- Avoid Redshift when the workload is primarily large-scale Transformation or batch processing rather than final serving and consumption.
- Avoid Redshift when the architecture needs flexible governed consumption over Iceberg datasets without cluster management overhead.

### Apache Iceberg Advantages

- supports ACID table behavior
- supports schema evolution
- supports partition evolution
- supports a durable and governed Open Table Format strategy across the Data Platform
- helps maintain a consistent storage and consumption model across processing and distribution layers

These advantages are why Iceberg is mandatory from ISC onward.

### Apache Airflow vs AWS Step Functions

- Airflow fits broader workflow management patterns where teams need DAG-oriented orchestration and scheduling flexibility.
- Step Functions fits AWS-native orchestration with explicit state handling and strong integration into AWS services.
- Selection should follow architecture fit and operational clarity, not tool familiarity alone.

### DP-EH Processing Preference

- DP-EH should favor scalable industrialized processing patterns.
- Spark, Glue, and dbt are the primary preferred frameworks for enterprise-scale processing.
- Redshift should not replace Spark, Glue, or dbt for large-scale Transformation in DP-EH.

### DP-SP Processing Flexibility

- DP-SP may choose industrialized processing similar to DP-EH when domain scale requires it.
- DP-SP may also choose lighter visual patterns such as Glue Studio when autonomy, speed, and local delivery needs justify them, but those patterns must still produce Apache Iceberg-standardized outputs.
- This flexibility does not change the requirement to standardize landed and processed data in Apache Iceberg.

### SageMaker Unified Studio Guidance

- In DP-EH and DP-SP, SageMaker Unified Studio is appropriate for ML and advanced analytics workflows, including data exploration, feature engineering, experimentation, and model development.
- In DDC, SageMaker Unified Studio is limited to discovery and interaction activities such as catalog exploration, data profiling, data discovery, and subscription workflows.
- In DDC, SageMaker Unified Studio must not be used for Data Product generation, large-scale Transformation, or other processing responsibilities that belong to DP-EH or DP-SP.

## What This Mapping Is NOT

This mapping is not:

- a product feature catalog
- a mandatory one-service-only prescription for every workload
- an implementation runbook
- a replacement for component architecture documents
- a justification to bypass architecture boundaries
- a basis for using IAM Users or non-Iceberg default table formats

## Summary

This service mapping connects the Hub-and-Spoke Architecture to the AWS and engineering toolkit in scope for the repository. Its core standards are explicit: IAM Roles only, Apache Iceberg as the mandatory table standard from ISC onward, Redshift as a final serving layer rather than a heavy-processing default, and clear separation between shared platform services, enterprise hub processing, spoke processing, and governed distribution.
