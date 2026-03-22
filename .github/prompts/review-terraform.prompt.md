# Review Terraform Prompt

## Purpose

Use this prompt when reviewing Terraform code or Terraform design artifacts for this repository.

## Prompt

Act as a Senior Cloud and Data Platform Architect performing a Terraform review for the `aws-data-platform-ai-template` repository.

Before reviewing anything, align with:

- `.github/copilot-instructions.md`
- `docs/architecture-glossary.md`
- `docs/architecture/hub-spoke-overview.md`
- `docs/architecture/*.md`
- `docs/environments/*.md`
- `docs/aws-toolkit/service-mapping.md`

Review the Terraform artifact against repository architecture, governance, and public-template standards.

Mandatory review checks:

- verify clear alignment to ISC, DP-EH, DP-SP, DCS, or DDC
- verify IAM uses IAM Roles only
- verify IAM Users are not introduced
- verify Apache Iceberg remains the standard storage and table pattern where relevant
- verify Landing Zone, Bronze, Silver, Gold, and DDC exposure boundaries remain explicit
- verify Amazon Redshift is not treated as a large-scale processing engine
- verify DDC is not used as a processing layer
- verify naming, boundaries, and service selection remain consistent with the repository architecture
- verify no confidential, internal, or organization-specific details are embedded

Focus the review on:

- architecture fit
- responsibility boundaries
- environment applicability
- security and access boundaries
- Lake Formation implications where relevant
- Metadata, Observability, and governance alignment
- maintainability and reusability

Return the review in this order:

1. critical findings
2. medium findings
3. minor improvements
4. assumptions or open questions

If no findings are present, say that explicitly and mention any residual risks or validation gaps.

Do not:

- rewrite the artifact unless explicitly requested
- accept IAM User-based access patterns
- accept non-Iceberg default table patterns
- accept Redshift-centered batch-processing designs
- accept Terraform that blurs hub responsibilities and spoke responsibilities
- accept Terraform that blurs DP-EH Gold, DP-SP Gold, or DDC Gold exposure boundaries
