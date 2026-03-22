# aws-data-platform-ai-template

A public foundation repository for designing, documenting, and accelerating AWS-based enterprise data platform engineering using a Hub-and-Spoke Architecture model, modern data tooling, and AI-assisted development workflows with GitHub Copilot, Visual Studio Code, and Codex.

This repository is intended to serve as a reusable starting point for architects, engineers, technical product owners, quality roles, and platform teams who need a clear structure for building and governing AWS data platforms across multiple environments and organizational domains.

---

## Purpose

The purpose of this repository is to provide a readable and extensible framework that helps engineering teams:

- structure an AWS Data Platform using a Hub-and-Spoke Architecture model
- align engineering roles around shared responsibilities and delivery artifacts
- define architecture components, environment usage, and service boundaries consistently
- document AWS service mappings and platform standards in a reusable way
- prepare the repository for AI-assisted engineering with GitHub Copilot and Codex
- create a generic public template that can later be adapted in downstream private repositories

This repository is intentionally generic. It is designed to be understandable and useful even without AI tooling, while also being ready for AI-assisted workflows.

---

## Scope

This repository focuses on the foundation layer of an AWS enterprise Data Platform template.

It includes:

- repository structure
- architecture glossary
- architecture overview
- component-level architecture definitions
- environment model
- role definitions
- AWS service mapping
- AI instruction and prompt scaffolding
- governance placeholders
- reusable patterns and templates

It does not yet include production-ready implementation code. The goal of the current phase is to establish a clean, understandable, and extensible architecture system.

---

## Architecture Model

This repository is based on a Hub-and-Spoke Architecture model composed of five primary architecture components:

- ISC - Ingestion Service Center
- DP-EH - Data Processing Center - Enterprise Hub
- DP-SP - Data Processing Center - Spoke
- DCS - Data Core Services
- DDC - Data Distribution Center

### High-level architecture flow

- ISC -> DDC
- DDC <-> DP-EH
- DDC <-> DP-SP
- DCS -> ISC
- DCS -> DP-EH
- DCS -> DP-SP
- DCS -> DDC

This model is intended to support both centralized and domain-aligned data platform patterns while preserving clear governance, Metadata, access control, and operational boundaries.

---

## Environment Model

The repository uses the following environment model:

- DIT - Sandbox
- DEV - Development
- QA - Quality Assurance
- PPRD - Pre Production
- PRD - Production

### Environment usage by architecture component

ISC, DP-EH, DCS, and DDC use:

- DIT
- DEV
- QA
- PPRD
- PRD

DP-SP uses:

- DIT
- DEV
- PPRD
- PRD

This distinction reflects the repository rule that DP-SP does not use a standalone QA stage in the same way as shared platform services.

---

## Mandatory Platform Standards

The following standards are mandatory across the repository:

### IAM

- AWS IAM access must use IAM Roles only.
- IAM Users are not used in the platform.

### Data format

- Apache Iceberg is the standard Open Table Format.
- From ISC onward, data must be landed and standardized in Apache Iceberg.

### Redshift

- Amazon Redshift is used only to store and serve final Data Products.
- Amazon Redshift is not the default engine for large-scale Transformation or heavy batch processing.
- DP-EH and DP-SP may use Redshift as producer clusters when their strategy requires it.
- DDC may use Redshift as consumer clusters when consumption strategy requires it.

### Processing

- DP-EH favors Spark, Glue, and dbt for enterprise-scale processing.
- DP-SP may use the same industrialized stack or lighter tools such as AWS Glue Studio and AWS Glue DataBrew where that better fits spoke needs.

### Consumption

- DDC supports both Redshift-based serving and S3 plus Apache Iceberg plus Athena serverless consumption patterns.

### SageMaker Unified Studio

- DP-EH and DP-SP may use SageMaker Unified Studio for ML, analytics, experimentation, and model-development workflows.
- DDC may use SageMaker Unified Studio only for discovery, profiling, catalog exploration, and subscription-oriented interaction.
- DDC must not use SageMaker Unified Studio for data processing or Data Product generation.

---

## Current Repository Artifacts

The repository currently defines:

- controlled vocabulary in `docs/architecture-glossary.md`
- repository-level architecture narrative in `docs/architecture/hub-spoke-overview.md`
- component-level definitions in `docs/architecture/*.md`
- environment definitions in `docs/environments/*.md`
- role definitions in `docs/roles/*.md`
- AWS service mapping in `docs/aws-toolkit/service-mapping.md`
- AI repository instructions in `.github/copilot-instructions.md`
- prompt and instruction scaffolding in `.github/prompts/*` and `.github/instructions/*`

---

## Supported Roles

This template currently includes role artifacts for:

- Cloud Architect
- Cloud DevOps
- Data Architect
- Data Engineer
- Data Platforms Architect
- Data Platforms Operations
- Data QA Engineer
- Technical Product Owner

Each role is documented as a repository artifact with mission, scope, architecture alignment, responsibilities, boundaries, collaboration points, environment applicability, and success criteria.

---

## Primary Cloud and Engineering Toolkit

This repository is oriented to AWS and related engineering tools commonly used in enterprise data platforms.

Examples in scope include:

- AWS Glue Studio
- AWS Glue DataBrew
- AWS Glue Data Catalog
- AWS Glue Crawler
- AWS Glue API
- AWS Glue jobs system
- AWS Glue Visual ETL
- AWS Glue Data Quality
- AWS Secrets Manager
- AWS Glue Zero-ETL integrations
- dbt
- Apache Spark
- PySpark
- SparkSQL
- Terraform
- AWS Step Functions
- AWS Lambda
- AWS IAM
- AWS Lake Formation
- SageMaker Unified Studio
- Amazon S3
- Amazon Athena
- Apache Iceberg
- JDBC endpoints for Athena and Redshift
- Amazon Q
- Amazon Bedrock
- AWS CLI
- Apache Airflow
- Amazon Redshift
- Amazon EMR
- Amazon MSK
- Amazon SQS
- Amazon CloudWatch
- AWS CloudTrail
- Dynatrace
- Amazon EventBridge
- Amazon EC2

Detailed architecture-to-service guidance belongs in `docs/aws-toolkit/service-mapping.md`.

---

## Repository Structure

```text
aws-data-platform-ai-template/
|-- .github/
|   |-- copilot-instructions.md
|   |-- prompts/
|   `-- instructions/
|-- docs/
|   |-- vision.md
|   |-- architecture-glossary.md
|   |-- architecture/
|   |-- environments/
|   |-- roles/
|   `-- aws-toolkit/
|-- patterns/
|   |-- isc/
|   |-- dp-eh/
|   |-- dp-sp/
|   |-- dcs/
|   `-- ddc/
|-- templates/
|   |-- terraform/
|   |-- glue/
|   |-- pyspark/
|   |-- dbt/
|   |-- stepfunctions/
|   |-- lambda/
|   |-- airflow/
|   `-- observability/
|-- examples/
|-- governance/
|   `-- review-checklists/
|-- config/
|-- README.md
|-- LICENSE
|-- NOTICE
`-- CONTRIBUTING.md
```

---

## Design Principles

This repository is being built around a few key principles.

### 1. Readable without AI

A new engineer should be able to understand the purpose, structure, and direction of the repository without needing AI tooling.

### 2. AI-ready by design

The repository should be structured so that GitHub Copilot and Codex can work with it effectively through instructions, prompts, patterns, and reusable templates.

### 3. Generic in public, adaptable in enterprise

The public repository should contain reusable architecture and engineering guidance without enterprise-confidential content. Organization-specific adaptations should be added in private downstream repositories.

### 4. Architecture-first

The repository should reflect intentional platform design, not just code snippets. Patterns, relationships, roles, standards, and environment rules should be explicit.

### 5. Reusable engineering foundation

The long-term objective is to make this repository a template that accelerates delivery for AWS Hub-and-Spoke data platforms across teams and use cases.

---

## Current Status

This repository is in an incremental foundation phase.

The current objective is to establish:

- a consistent architecture vocabulary
- one coherent architecture narrative
- clear component boundaries
- explicit environment behavior
- role clarity
- service-selection guardrails
- AI-ready repository instructions and prompts

Implementation templates, examples, and downstream engineering accelerators can be added later without weakening the architecture system defined here.

---

## Contribution Approach

Contributions are welcome when they improve the clarity, reuse, and engineering value of the template.

Please keep contributions:

- generic and reusable
- free of confidential or enterprise-restricted information
- aligned with the Hub-and-Spoke Architecture model
- consistent with the repository naming and documentation conventions
- consistent with the glossary and mandatory platform standards

If this repository is later adopted inside an enterprise, organization-specific policies, standards, and confidential implementation details should be added in a downstream private repository rather than in the public foundation.

---

## Author

Created and maintained by Manuel Hernandez Giuliani.

This repository represents a public engineering foundation for AWS Data Platform Architecture and AI-assisted development workflows.
