# Gold Serving to Redshift Pattern

## Purpose

This pattern defines how final Gold Data Products are served through Amazon Redshift.

## Architecture Alignment

- processing owner: `DP-EH` or constrained `DP-SP`
- serving owner: `DDC`
- governance support: `DCS`

## Pattern Summary

1. Gold-ready data is produced outside Redshift.
2. A controlled serving increment or serving snapshot is staged in S3.
3. `DDC` loads the staged data into Redshift through `COPY`.
4. `DDC` updates final serving tables through a controlled merge or upsert pattern.

## Responsibilities

- processing remains outside Redshift
- Redshift is the final serving layer only
- DDC owns consumer-serving exposure

## Typical Service Fit

- Amazon Redshift
- Amazon S3
- AWS Lake Formation
- IAM Roles

## Mandatory Rules

- Redshift is not the main processing engine
- IAM Roles only
- Gold only for normal consumer exposure
- producer-side Redshift structures must not replace DDC
