# GitHub Copilot Repository Instructions

This repository defines a reusable foundation for AWS-based enterprise data platform engineering using a Hub-and-Spoke architecture model.

These instructions apply to all code, documentation, architecture artifacts, scripts, templates, and engineering outputs generated in this repository.

## Core Intent

Always produce outputs that strengthen this repository as a clean, reusable, enterprise-grade public template for AWS data platform architecture and AI-assisted engineering.

Favor clarity, structure, reusability, and professional engineering quality over speed or brevity.

Do not generate content that assumes confidential enterprise context, internal Schneider Electric information, hidden infrastructure details, or organization-specific standards unless they are explicitly provided in the repository.

## Architecture Alignment

All outputs must align with the repository architecture model and terminology.

### Architecture components

- ISC = Ingestion Service Center
- DP-EH = Data Processing Center - Enterprise Hub
- DP-SP = Data Processing Center - Spoke
- DCS = Data Core Services
- DDC = Data Distribution Center

### Expected architecture flow

- ISC -> DDC
- DDC <-> DP-EH
- DDC <-> DP-SP
- DCS -> ISC
- DCS -> DP-EH
- DCS -> DP-SP
- DCS -> DDC

When generating designs, code, prompts, templates, examples, or documentation, explicitly state which architecture component or interaction is being addressed.

Do not blur shared enterprise services with spoke-specific services. Keep centralized patterns and spoke patterns clearly separated.

## Environment Model

Use the following environment model consistently across documentation, examples, templates, code comments, and architecture artifacts:

- DIT = Sandbox
- DEV = Development
- QA = Quality Assurance
- PPRD = Pre Production
- PRD = Production

### Environment applicability

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

Do not invent additional environments unless explicitly requested.

## Cloud and Tooling Scope

Prefer solutions aligned with the AWS ecosystem and the engineering toolkit in scope for this repository.

### Primary technologies in scope

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

When multiple implementation options exist, prefer the option that is most aligned with AWS-native services, clear governance, operational maintainability, and reusable enterprise patterns.

## Output Quality Standards

Always generate outputs that are:

- professional
- explicit
- maintainable
- readable by humans first
- reusable in enterprise contexts
- generic enough for public sharing
- aligned with platform governance and architecture intent

Do not produce shallow stubs when a meaningful structure is expected.

When creating documentation, explain the why, not only the what.

When creating architecture artifacts, include purpose, scope, responsibilities, boundaries, and interactions.

When creating engineering templates, include placeholders, comments, and a clear extension path.

## Mandatory Code and Script Header Standard

All scripts and code files generated for this repository must include a header at the top with the following fields:

- License
- Author
- Date Created
- Date Modified
- Purpose

This is mandatory for all code and scripts.

### Required header template

For shell-style comments:

```bash
# License: Apache 2.0
# Author: Manuel Hernández Giuliani
# Date Created: YYYY-MM-DD
# Date Modified: YYYY-MM-DD
# Purpose: Short clear description of what the code or script does
```

For Python-style comments:

```python
# License: Apache 2.0
# Author: Manuel Hernández Giuliani
# Date Created: YYYY-MM-DD
# Date Modified: YYYY-MM-DD
# Purpose: Short clear description of what the code or script does
```

For SQL-style comments:

```sql
-- License: Apache 2.0
-- Author: Manuel Hernández Giuliani
-- Date Created: YYYY-MM-DD
-- Date Modified: YYYY-MM-DD
-- Purpose: Short clear description of what the code or script does
```

For Terraform-style comments:

```hcl
# License: Apache 2.0
# Author: Manuel Hernández Giuliani
# Date Created: YYYY-MM-DD
# Date Modified: YYYY-MM-DD
# Purpose: Short clear description of what the code or script does
```

If the file type uses another comment style, adapt the same fields to the correct syntax.

Do not omit this header.

## Language and Naming Conventions

Use precise and consistent naming.

Prefer names that reflect:
- architecture role
- functional responsibility
- environment applicability
- AWS service intent

Avoid vague names such as:
- script1
- temp_job
- test_pipeline_final_v2
- misc_utils

Prefer names such as:
- isc_s3_ingestion_job.py
- dp_eh_iceberg_curated_table.tf
- ddc_distribution_workflow.asl.json
- dcs_lakeformation_permissions.tf

Use lowercase kebab-case for markdown file names unless the repository already defines a different standard.

Use lowercase snake_case for Python modules and scripts.

Use clear Terraform resource names with consistent prefixes.

## Documentation Standards

When generating markdown documents:

- start with a clear title
- explain purpose and scope early
- use consistent terminology from this repository
- keep sections logically ordered
- include architecture alignment when relevant
- include environment applicability when relevant
- keep enterprise readability high
- do not include internal confidential assumptions

When writing role definitions, include:
- mission
- responsibilities
- expected deliverables
- key decisions
- boundaries
- collaboration points

When writing architecture component definitions, include:
- purpose
- responsibilities
- inbound and outbound interactions
- typical AWS services
- data and control boundaries
- environment usage
- design considerations

## Code Generation Standards

When generating code:

- include the mandatory file header
- prefer production-structured code over throwaway snippets
- add comments where they improve maintainability
- avoid hardcoding secrets, account ids, ARNs, passwords, tokens, or endpoints
- use placeholders when secure values are required
- include error handling where appropriate
- prefer explicit configuration over hidden assumptions
- keep modular separation clear
- make code easy to test and extend

For Python:
- prefer readable modular functions
- include a main entry point when appropriate
- add docstrings when useful
- avoid unnecessary cleverness

For Terraform:
- structure resources cleanly
- use variables and outputs thoughtfully
- avoid embedding secrets
- reflect environment and architecture intent in naming and tagging
- favor reusability and clarity over excessive abstraction

For SQL and dbt:
- write readable SQL
- make transformations traceable
- separate staging, intermediate, and curated logic when relevant
- document assumptions clearly

For PySpark:
- write readable transformations
- make dataflow traceable
- preserve lineage intent where relevant
- avoid unnecessary complexity
- explain partitioning or performance decisions when introduced

## Architecture and Design Output Standards

When generating architecture proposals, ADRs, design notes, or patterns:

- explicitly identify the architecture component
- describe why the design exists
- state assumptions
- list AWS services involved
- identify interfaces and dependencies
- identify environment applicability
- mention governance, observability, and security implications
- separate enterprise hub logic from spoke logic

When relevant, discuss:
- IAM and access boundaries
- Lake Formation implications
- metadata and catalog considerations
- observability with CloudWatch, CloudTrail, and Dynatrace
- orchestration choices such as Step Functions or Airflow
- storage format decisions such as Apache Iceberg
- consumption patterns through Athena, Redshift, APIs, or downstream distribution

## Prompt and Template Generation Standards

When generating prompt files or reusable templates:

- make them practical
- make them easy to reuse
- state the expected context
- state expected output
- align them to a role, component, or workflow
- avoid ambiguous or overly generic prompt wording
- include architecture and environment cues when useful

Prompt files should help engineers produce repeatable results, not one-off prose.

## Governance and Review Alignment

Favor outputs that support disciplined engineering practices.

When relevant, include or encourage:
- naming conventions
- reviewability
- branch discipline
- environment clarity
- testability
- observability
- security awareness
- documentation completeness

Do not recommend direct commits to main.

Assume work should normally happen in feature branches, then flow into dev, then main.

## Public Template Safety Rules

This repository is a public foundation template.

Therefore:

- do not generate enterprise-confidential content
- do not embed company-restricted operational details
- do not reference internal URLs, accounts, data sets, or ticket systems unless explicitly provided
- do not present hypothetical internal standards as facts
- keep outputs reusable and safe for public sharing

If organization-specific adaptation is needed, present it as a downstream private extension pattern, not as part of the public core.

## Preferred Style

Use a tone that is:
- professional
- direct
- structured
- senior-engineering oriented
- practical
- clear enough for architects, engineers, and technical product owners

Avoid:
- unnecessary hype
- vague buzzwords without implementation meaning
- overly casual phrasing
- excessive brevity when clarity is needed

## Default Assumptions

Unless explicitly told otherwise:

- assume AWS is the target cloud
- assume Apache 2.0 is the repository license
- assume Manuel Hernández Giuliani is the author
- assume all generated code must include the mandatory header
- assume outputs should strengthen a public reusable template
- assume enterprise-grade quality is expected
