# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Near-runnable Terraform starter for the ingestion-s3-to-redshift-spark example covering ISC Landing Zone, DP-EH Spark-based Iceberg processing, controlled S3 staging for Redshift loads, and DDC Redshift serving.

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
  redshift_serverless_name = "${local.name_prefix}-ddc-gold"

  standard_tags = {
    repository      = "aws-data-platform-ai-template"
    use_case        = var.use_case
    environment     = upper(var.environment)
    managed_by      = "terraform"
    example_pattern = "ingestion-s3-to-redshift-spark"
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

resource "aws_s3_bucket" "redshift_stage" {
  bucket = "${local.name_prefix}-redshift-stage"
  tags   = merge(local.standard_tags, { architecture_component = "DDC" })
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

data "aws_iam_policy_document" "dp_eh_spark_runtime" {
  statement {
    sid    = "AllowLandingReadWarehouseAndStageWrite"
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
      "${aws_s3_bucket.platform_warehouse.arn}/*",
      aws_s3_bucket.redshift_stage.arn,
      "${aws_s3_bucket.redshift_stage.arn}/*"
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

data "aws_iam_policy_document" "ddc_redshift_copy" {
  statement {
    sid    = "AllowReadFromRedshiftStage"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.redshift_stage.arn,
      "${aws_s3_bucket.redshift_stage.arn}/*"
    ]
  }
}

module "dp_eh_spark_runtime_role" {
  source = "../../../templates/terraform/modules/dcs_iam_role"

  project                = var.project
  component              = "dcs"
  environment            = var.environment
  role_purpose           = "dp-eh-spark-runtime"
  assume_role_principals = ["emr-serverless.amazonaws.com"]
  inline_policy_json     = data.aws_iam_policy_document.dp_eh_spark_runtime.json

  tags = {
    workload_component = "DP-EH"
    workload_type      = "spark-job"
    medallion_scope    = "bronze-silver-gold"
  }
}

module "ddc_redshift_copy_role" {
  source = "../../../templates/terraform/modules/dcs_iam_role"

  project                = var.project
  component              = "dcs"
  environment            = var.environment
  role_purpose           = "ddc-redshift-copy"
  assume_role_principals = ["redshift.amazonaws.com", "redshift-serverless.amazonaws.com"]
  inline_policy_json     = data.aws_iam_policy_document.ddc_redshift_copy.json

  tags = {
    workload_component = "DDC"
    workload_type      = "redshift-serving"
    medallion_scope    = "gold-serving"
  }
}

resource "aws_redshiftserverless_namespace" "ddc_gold" {
  namespace_name      = local.redshift_serverless_name
  db_name             = var.redshift_database_name
  admin_username      = var.redshift_admin_username
  admin_user_password = var.redshift_admin_password
  iam_roles           = [module.ddc_redshift_copy_role.role_arn]

  tags = merge(local.standard_tags, { architecture_component = "DDC" })
}

resource "aws_redshiftserverless_workgroup" "ddc_gold" {
  workgroup_name       = local.redshift_serverless_name
  namespace_name       = aws_redshiftserverless_namespace.ddc_gold.namespace_name
  base_capacity        = var.redshift_base_capacity
  publicly_accessible  = false
  enhanced_vpc_routing = true

  tags = merge(local.standard_tags, { architecture_component = "DDC" })
}
