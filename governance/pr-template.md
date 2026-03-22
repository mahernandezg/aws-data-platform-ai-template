# Pull Request Template

## Summary

Describe the change in 2-5 sentences.

## Change Type

Mark the relevant type:

- architecture
- governance
- documentation
- prompt or instruction
- template
- example
- configuration

## Architecture Impact

State the affected architecture components:

- ISC
- DP-EH
- DP-SP
- DCS
- DDC

State the affected Medallion layers if relevant:

- Landing Zone
- Bronze
- Silver
- Gold

## Environment Impact

State the affected environments if relevant:

- DIT
- DEV
- QA
- PPRD
- PRD

## Standards Check

Confirm whether the change preserves the mandatory platform standards:

- IAM Roles only
- Apache Iceberg from ISC onward
- Redshift serving only
- Medallion ownership
- multi-account rules
- multi-region rules

If one of these standards changes, explain why and list every document or file updated to keep the repository consistent.

## Files Changed

List the most important files changed and why they changed.

## Review Guidance

Tell reviewers what to focus on:

- architecture consistency
- security posture
- documentation clarity
- machine-readable config alignment
- example correctness

## Validation

State what was validated:

- text-level review
- syntax check
- terraform validate
- unit tests
- not run

## Public Template Safety

Confirm:

- no confidential enterprise content was added
- no internal URLs or internal accounts were added
- the change remains generic and reusable
