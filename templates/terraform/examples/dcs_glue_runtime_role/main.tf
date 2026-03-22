# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Near-runnable Terraform example showing IAM role-only provisioning for an ISC Glue runtime pattern governed by DCS.

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

data "aws_iam_policy_document" "isc_glue_runtime" {
  statement {
    sid    = "AllowGlueJobBucketAccess"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.landing_bucket_name}",
      "arn:aws:s3:::${var.landing_bucket_name}/*"
    ]
  }

  statement {
    sid    = "AllowCatalogReadWrite"
    effect = "Allow"

    actions = [
      "glue:GetDatabase",
      "glue:GetTable",
      "glue:CreateTable",
      "glue:UpdateTable"
    ]

    resources = ["*"]
  }
}

module "isc_glue_runtime_role" {
  source = "../../modules/dcs_iam_role"

  project                = var.project
  component              = "dcs"
  environment            = var.environment
  role_purpose           = "isc-glue-runtime"
  assume_role_principals = ["glue.amazonaws.com"]
  inline_policy_json     = data.aws_iam_policy_document.isc_glue_runtime.json

  tags = {
    workload_component = "ISC"
    workload_type      = "glue-job"
  }
}

output "isc_glue_runtime_role_arn" {
  description = "IAM role ARN for the ISC Glue runtime example."
  value       = module.isc_glue_runtime_role.role_arn
}
