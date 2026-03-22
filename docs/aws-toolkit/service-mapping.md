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

## Mapping Principles

- Service selection must start from architecture responsibility, not from product preference.
- Shared foundational concerns belong in DCS and should not be duplicated in every component.
- Hub responsibilities and Spoke responsibilities must remain clearly separated.
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

### Data Product Consumption Pattern

Data Products may be consumed through two primary patterns in DDC:

- Amazon Redshift as a serving and read-performance optimization layer
- Amazon S3 plus Apache Iceberg plus Amazon Athena as a serverless consumption pattern

Redshift standard:

- Amazon Redshift is used only to store and serve final Data Products.
- Amazon Redshift is not the default engine for massive-scale Transformation or heavy batch processing.
- Redshift usage is limited to databases, schemas, tables, views, materialized views, and optimizations that improve read performance.

Athena and Iceberg standard:

- Not all Data Products require Amazon Redshift.
- Amazon S3 plus Apache Iceberg plus Amazon Athena is a valid consumption pattern in DDC.
- This applies when a hub or spoke does not provision a Redshift cluster or when serverless analytics is the better fit.
- Iceberg remains the standard format even when Athena is the consumption engine.

### Amazon Redshift Deployment Pattern

Amazon Redshift usage depends on component role.

For DP-EH and DP-SP:

- Redshift may be used as producer clusters.
- Producer clusters may be none, one, or many.
- The decision depends on hub or spoke strategy and on whether serving-optimized Data Product structures are needed close to the producing component.

For DDC:

- Redshift is used as consumer clusters.
- Consumer clusters may be one or many.
- The decision depends on Distribution and consumption strategy, especially where read performance and consumer-facing query optimization are required.

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

### Processing

Typical services:

- Apache Spark
- PySpark
- SparkSQL
- AWS Glue jobs system
- DBT
- Amazon EMR
- AWS Glue Studio
- AWS Glue DataBrew

### Storage

Typical services:

- Amazon S3
- Apache Iceberg

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

Boundaries:

- ISC is not the place for broad enterprise Transformation ownership.
- ISC is not the place for consumer-facing Distribution.
- ISC should not treat non-Iceberg landing structures as the default platform pattern.
- ISC should not introduce IAM User-based access. Runtime access must use IAM Roles.

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
- Redshift may be used as a producer cluster when serving-oriented structures are required, but not as the main heavy-processing engine.
- SageMaker Unified Studio fits exploration, feature engineering, ML experimentation, and model development in the hub.

Boundaries:

- DP-EH is not the primary consumer-facing Distribution layer.
- DP-EH should not rely on Redshift as the default massive-scale processing engine.
- DP-EH should not produce non-Iceberg default tables from shared processing flows.
- DP-EH should not duplicate DCS governance responsibilities.

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
- AWS Glue DataBrew
- AWS Step Functions
- Amazon S3
- Apache Iceberg
- AWS Glue Data Catalog
- AWS Glue Data Quality
- Amazon Redshift
- SageMaker Unified Studio

Why they fit:

- DP-SP may use the same industrialized frameworks as DP-EH when a spoke needs scalable engineering depth.
- DP-SP may also use lighter visual processing tools such as Glue Studio and DataBrew where that better matches spoke autonomy and local delivery needs.
- S3 plus Iceberg remains the mandatory storage and table standard.
- Redshift may be used as a producer cluster when spoke strategy requires serving-oriented structures, but it is not the default engine for heavy batch processing.
- SageMaker Unified Studio fits spoke-side exploration, feature engineering, ML experimentation, and model development.

Boundaries:

- DP-SP is not the place to duplicate shared Control Plane services.
- DP-SP should not bypass DCS governance or DDC distribution principles.
- DP-SP should not treat visual tools as an excuse to abandon Iceberg standardization.
- DP-SP does not use QA in the environment model, so validation patterns must be designed accordingly.

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
- Athena is a valid serverless consumption engine over Iceberg datasets.
- Redshift is a valid consumer-cluster serving layer where query performance and read optimization justify it.
- SageMaker Unified Studio fits discovery, profiling, catalog exploration, and subscription workflows in DDC.

Boundaries:

- DDC is not the primary large-scale processing layer.
- DDC must not use SageMaker Unified Studio for Data Product generation or large-scale Transformation.
- DDC should not position Redshift as the default processing engine.
- DDC should not expose consumer-facing assets outside role-based access and shared governance controls.

## Cross-Cutting Core Services Mapping

### AWS IAM

- IAM Roles only are permitted.
- IAM Users are not used in the platform.
- Workload execution, automation, and operational access must be role-based and assumable.
- IAM governance should be centralized through DCS.

### AWS Lake Formation

- Lake Formation supports governed data access and policy enforcement.
- It should be treated as a DCS-governed service that reinforces controlled access to Iceberg-backed data assets.

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

- Athena is a strong fit for serverless analytics over S3 and Iceberg-backed Data Products.
- Redshift is a strong fit for final serving structures, read optimization, consumer-facing query performance, and curated delivery patterns.
- Redshift should be positioned as a serving and consumption optimization layer, not as the main engine for heavy large-scale data processing.

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

### DP-SP Processing Flexibility

- DP-SP may choose industrialized processing similar to DP-EH when domain scale requires it.
- DP-SP may also choose lighter visual or no-code patterns such as Glue Studio and DataBrew when autonomy, speed, and local delivery needs justify them.
- This flexibility does not change the requirement to standardize landed and processed data in Apache Iceberg.

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
