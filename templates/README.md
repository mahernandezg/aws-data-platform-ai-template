# Templates

## Purpose

This directory is the practical accelerator layer of the repository.

It provides starter templates that translate the repository architecture into reusable implementation scaffolds without pretending to be full production assets.

## Template Families

- [`terraform`](./terraform/README.md)
- [`glue`](./glue/README.md)
- [`emr`](./emr/README.md)
- [`pyspark`](./pyspark/README.md)
- [`dbt`](./dbt/README.md)
- [`stepfunctions`](./stepfunctions/README.md)
- [`redshift`](./redshift/README.md)
- [`observability`](./observability/README.md)

## Repository Standards

All templates in this directory should preserve:

- mandatory code headers
- explicit architecture component declaration
- explicit environment applicability
- IAM Roles only
- Apache Iceberg from ISC onward
- Redshift serving only
- observability placeholders where relevant
- lineage placeholders where relevant

## Template Intent

These templates are:

- high-quality starters
- architecture-aligned
- public-safe
- reusable

They are not full production reference implementations.
