# Platform Standards

## Purpose

This document captures the non-negotiable platform standards enforced across the repository.

## Mandatory Standards

### IAM

- IAM Roles only
- IAM Users are not used in the platform

### Data Format

- Apache Iceberg is the standard Open Table Format
- Apache Iceberg is mandatory from ISC onward

### Redshift

- Amazon Redshift is used only to store and serve final Gold Data Products
- Amazon Redshift is not the main processing engine
- DP-EH and DP-SP may use producer-side Redshift structures only within that boundary
- DDC is the final consumer-serving Redshift layer where Redshift is used

### Medallion Ownership

- ISC owns the Landing Zone only
- DP-EH owns enterprise Bronze, Silver, and Gold
- DP-SP owns spoke Bronze and Silver, plus constrained Gold for domain-specific outputs or enhancements of DP-EH Gold
- DDC exposes Gold to consumers by default
- AI-oriented access to Bronze, Silver, or Gold is a controlled exception only

### Environment Model

- DIT is shared experimentation only
- DP-SP does not use QA

### Account Model

- DEV, QA, PPRD, and PRD are isolated by AWS account
- ISC, DP-EH, and DDC have controlled environment account groups for DEV, QA, PPRD, and PRD
- DP-SP has controlled environment account groups for DEV, PPRD, and PRD only
- DIT is shared through DIT-1 to DIT-4 only

### Region Model

- Controlled platform operation is multi-region in `us-east-1` and `eu-west-1`
- Shared DIT exists only in `eu-west-1`

## Governance Rule

If a change affects one of these standards, the change must update all impacted repository artifacts, not just one document.
