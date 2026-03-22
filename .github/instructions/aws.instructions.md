# AWS Instructions

Use these instructions when generating AWS-oriented guidance, examples, templates, or architecture mappings for this repository.

## Primary Objective

Select and describe AWS services according to architecture fit, governance clarity, and operational maintainability.

Service selection must follow repository architecture boundaries, not product familiarity.

## Mandatory Platform Standards

### IAM

- Use IAM Roles only.
- Do not use IAM Users in generated guidance, templates, or examples.
- Assume workload execution, automation, and operational access are role-based and assumable.

### Data Format

- Apache Iceberg is the standard Open Table Format across the Data Platform.
- From ISC onward, data must be landed and standardized in Apache Iceberg.
- Do not present unmanaged Hive-style table patterns as the default platform choice.

### Medallion

- ISC owns the Landing Zone only.
- DP-EH owns enterprise Bronze, Silver, and Gold processing.
- DP-SP owns spoke Bronze and Silver processing, plus constrained Gold ownership for domain-specific outputs or enhancements of DP-EH Gold assets.
- DDC exposes Gold Data Products to consumers by default.
- AI-oriented access to Bronze, Silver, or Gold is allowed only as a controlled exception.

### Redshift

- Amazon Redshift is used only to store and serve final Data Products.
- Do not position Redshift as the primary engine for large-scale Transformation or heavy batch processing.
- DP-EH and DP-SP may use Redshift as producer clusters when their strategy requires it.
- DDC may use Redshift as consumer clusters when consumption performance and serving strategy require it.

### Processing

- In DP-EH, favor Apache Spark, AWS Glue, and dbt for enterprise-scale processing.
- In DP-SP, the same stack may be used, or lighter tools such as AWS Glue Studio and AWS Glue DataBrew may be used when they better fit spoke needs.

### Consumption

- DDC supports both Redshift and S3 plus Apache Iceberg plus Athena consumption patterns.
- Athena is the preferred serverless option over Iceberg-backed datasets when a dedicated cluster is not justified.

### SageMaker Unified Studio

- In DP-EH and DP-SP, SageMaker Unified Studio may support exploration, feature engineering, experimentation, and model development.
- In DDC, SageMaker Unified Studio is limited to catalog exploration, profiling, discovery, and subscription workflows.
- Do not use SageMaker Unified Studio in DDC for processing or Data Product generation.

## Component-to-Service Intent

Use the following high-level alignment:

- ISC: ingestion services, orchestration services, S3, Iceberg, Metadata-supporting services
- DP-EH: large-scale processing services for enterprise Bronze, Silver, and Gold, orchestration, S3, Iceberg, optional producer Redshift serving structures
- DP-SP: domain-aligned processing services for spoke Bronze, Silver, and constrained Gold, optional lighter visual tools, S3, Iceberg, optional producer Redshift serving structures
- DCS: IAM, Lake Formation, Secrets Manager, CloudWatch, CloudTrail, Dynatrace, EventBridge, Terraform-aligned control services
- DDC: S3, Iceberg, Athena, Redshift consumer clusters, and governed Gold exposure to consumers

## Service-Selection Guidance

- Prefer AWS-native services when they improve operational clarity and governance fit.
- Prefer Step Functions over fragmented Lambda chains when explicit orchestration visibility is required.
- Prefer Glue when managed serverless data processing is the better fit.
- Prefer EMR with Spark when workload control or specialized Spark behavior materially matters.
- Prefer Athena for flexible serverless consumption over Iceberg-backed data.
- Prefer Redshift for high-performance structured consumption and BI-oriented serving patterns.

## Prohibited Patterns

Do not:

- describe IAM Users as part of the platform access model
- describe Redshift as the default transformation engine
- suggest leaving ISC outputs in non-Iceberg default formats
- treat DDC as a compute-heavy processing layer
- duplicate DCS control capabilities inside every component without explanation
- recommend service choices that blur hub and spoke boundaries
- recommend service choices that blur Landing Zone, Bronze, Silver, Gold, or DDC exposure boundaries
