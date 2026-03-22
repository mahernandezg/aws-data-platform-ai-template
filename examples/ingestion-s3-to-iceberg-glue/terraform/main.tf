# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Near-runnable Terraform starter for the ingestion-s3-to-iceberg example covering ISC Landing Zone, DP-EH Iceberg processing, and DDC Athena exposure.

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  name_prefix = "${var.project}-${var.environment}-${var.use_case}"

  standard_tags = {
    repository      = "aws-data-platform-ai-template"
    use_case        = var.use_case
    environment     = upper(var.environment)
    managed_by      = "terraform"
    example_pattern = "ingestion-s3-to-iceberg"
  }
}

resource "aws_s3_bucket" "isc_landing" {
  bucket = "${local.name_prefix}-isc-landing"
  tags   = merge(local.standard_tags, { architecture_component = "ISC" })
}

resource "aws_s3_bucket" "platform_warehouse" {
  bucket = "${local.name_prefix}-iceberg-warehouse"
  tags   = merge(local.standard_tags, { architecture_component = "DP-EH" })
}

resource "aws_glue_catalog_database" "bronze" {
  name = "${replace(local.name_prefix, "-", "_")}_bronze"
}

resource "aws_glue_catalog_database" "silver" {
  name = "${replace(local.name_prefix, "-", "_")}_silver"
}

resource "aws_glue_catalog_database" "gold" {
  name = "${replace(local.name_prefix, "-", "_")}_gold"
}

resource "aws_athena_workgroup" "ddc_gold" {
  name = "${local.name_prefix}-ddc-gold"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.platform_warehouse.bucket}/athena-results/"
    }
  }

  tags = merge(local.standard_tags, { architecture_component = "DDC" })
}

data "aws_iam_policy_document" "dp_eh_glue_runtime" {
  statement {
    sid    = "AllowLandingReadAndWarehouseWrite"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.isc_landing.arn,
      "${aws_s3_bucket.isc_landing.arn}/*",
      aws_s3_bucket.platform_warehouse.arn,
      "${aws_s3_bucket.platform_warehouse.arn}/*"
    ]
  }

  statement {
    sid    = "AllowGlueCatalogOperations"
    effect = "Allow"

    actions = [
      "glue:GetDatabase",
      "glue:CreateTable",
      "glue:GetTable",
      "glue:UpdateTable"
    ]

    resources = ["*"]
  }
}

module "dp_eh_glue_runtime_role" {
  source = "../../../templates/terraform/modules/dcs_iam_role"

  project                = var.project
  component              = "dcs"
  environment            = var.environment
  role_purpose           = "dp-eh-glue-runtime"
  assume_role_principals = ["glue.amazonaws.com"]
  inline_policy_json     = data.aws_iam_policy_document.dp_eh_glue_runtime.json

  tags = {
    workload_component = "DP-EH"
    medallion_scope    = "bronze-silver-gold"
  }
}
