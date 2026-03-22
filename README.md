# aws-data-platform-ai-template

A public foundation repository for designing, documenting, and accelerating AWS-based enterprise data platform engineering using a Hub-and-Spoke model, modern data tooling, and AI-assisted development workflows with GitHub Copilot, Visual Studio Code, and Codex.

This repository is intended to serve as a reusable starting point for engineers, architects, technical product owners, and platform teams who need a clear structure for building and governing AWS data platforms across multiple environments and organizational domains.

---

## Purpose

The purpose of this repository is to provide a readable and extensible framework that helps engineering teams:

- structure an AWS data platform using a Hub-and-Spoke architecture model
- align engineering roles around shared responsibilities and delivery artifacts
- define architecture building blocks and environment usage consistently
- document service mappings and platform patterns in a reusable way
- prepare the repository for AI-assisted engineering with GitHub Copilot and Codex
- create a generic public template that can later be adapted to enterprise-specific internal repositories

This repository is intentionally generic. It is designed to be understandable and useful even without AI tooling, while also being ready for AI-assisted workflows.

---

## Scope

This repository focuses on the foundation layer of an AWS enterprise data platform template.

It includes:

- base repository structure
- architecture glossary
- role definitions
- environment model
- AWS service mapping
- governance placeholders
- reusable patterns and templates
- GitHub Copilot instruction and prompt structure

It does not yet include production-ready implementation code. The goal of the first phase is to establish a clean, understandable, and extensible framework.

---

## Target Roles

This template is designed to support the following roles:

- Cloud Architect
- Data Engineer
- Cloud DevOps
- Data Platforms Architect
- Data QA Engineer
- Data Platform Technical Product Owner

Each role will eventually have its own responsibilities, artifacts, review criteria, and AI prompt support.

---

## Architecture Model

This repository is based on a Hub-and-Spoke data platform architecture model composed of five major building blocks:

- ISC — Ingestion Service Center
- DP-EH — Data Processing Center, Enterprise Hub
- DP-SP — Data Processing Center, Spoke
- DCS — Data Core Services
- DDC — Data Distribution Center

### High-level architecture flow

- ISC -> DDC
- DDC <-> DP-EH
- DDC <-> DP-SP
- DCS -> ISC
- DCS -> DP-EH
- DCS -> DP-SP
- DCS -> DDC

This model is intended to support both centralized and domain-oriented data platform patterns, balancing shared platform services with scalable delivery autonomy.

---

## Environment Model

The repository uses the following environment model:

- DIT — Sandbox
- DEV — Development
- QA — Quality Assurance
- PPRD — Pre Production
- PRD — Production

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

This distinction reflects the fact that spoke environments may have a different lifecycle and validation strategy than centralized shared services.

---

## Primary Cloud and Engineering Toolkit

This template is currently oriented to AWS and related engineering tools commonly used in modern enterprise data platforms.

### AWS and platform services in scope

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
- DBT
- Apache Spark
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
- S3 endpoints
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

---

## Repository Structure

aws-data-platform-ai-template/
├─ .github/
│  ├─ copilot-instructions.md
│  ├─ prompts/
│  └─ instructions/
├─ docs/
│  ├─ vision.md
│  ├─ architecture-glossary.md
│  ├─ roles/
│  ├─ architecture/
│  ├─ environments/
│  └─ aws-toolkit/
├─ patterns/
│  ├─ isc/
│  ├─ dp-eh/
│  ├─ dp-sp/
│  ├─ dcs/
│  └─ ddc/
├─ templates/
│  ├─ terraform/
│  ├─ glue/
│  ├─ pyspark/
│  ├─ dbt/
│  ├─ stepfunctions/
│  ├─ lambda/
│  ├─ airflow/
│  └─ observability/
├─ examples/
├─ governance/
│  └─ review-checklists/
├─ config/
├─ README.md
├─ LICENSE
├─ NOTICE
└─ CONTRIBUTING.md

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
The repository should reflect intentional platform design, not just code snippets. Patterns, relationships, roles, and environment rules should be explicit.

### 5. Reusable engineering foundation
The long-term objective is to make this repository a template that accelerates delivery for AWS Hub-and-Spoke data platforms across teams and use cases.

---

## Who this repository is for

This repository may be useful for:

- enterprise data platform architects
- cloud and DevOps engineers
- data engineers working with AWS analytics services
- technical product owners shaping platform backlogs
- teams designing a governed Hub-and-Spoke data platform model
- educators or mentors teaching modern enterprise data platform architecture

---

## Current Status

This repository is currently in its foundation phase.

The initial objective is to establish:

- repository structure
- documentation skeleton
- role and platform definitions
- architecture language
- environment and service mapping
- governance starting points

Implementation templates, examples, AI prompts, and engineering standards will be progressively added in later phases.

---

## Contribution Approach

Contributions are welcome when they improve the clarity, reuse, and engineering value of the template.

Please keep contributions:

- generic and reusable
- free of confidential or enterprise-restricted information
- aligned with the Hub-and-Spoke architecture model
- consistent with the repository naming and documentation conventions

See CONTRIBUTING.md for future contribution guidance.

---

## Licensing and Reuse

This repository is intended to support open and reusable engineering patterns. The exact license and reuse guidance are defined in:

- LICENSE
- NOTICE

If this repository is later adopted inside an enterprise, it is recommended to create a downstream internal repository that adds organization-specific policies, standards, and confidential implementation details separately from the public foundation.

---

## Roadmap

Planned evolution includes:

- repository-wide Copilot instructions
- role-specific prompt files
- AWS service design patterns
- Terraform and PySpark templates
- dbt and Glue starter structures
- architecture decision record patterns
- review checklists by role
- sample end-to-end Hub-and-Spoke implementations

---

## Author

Created and maintained by Manuel Hernández Giuliani.

This repository represents a public engineering foundation for AWS data platform architecture and AI-assisted development workflows.
