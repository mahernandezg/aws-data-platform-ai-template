# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Near-runnable Amazon Redshift Serverless serving starter for DDC Gold-serving workloads.

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
  name_prefix      = "${var.project}-${var.environment}-${var.serving_name}"
  namespace_name   = "${local.name_prefix}-namespace"
  workgroup_name   = "${local.name_prefix}-workgroup"

  standard_tags = {
    repository             = "aws-data-platform-ai-template"
    architecture_component = "DDC"
    environment            = upper(var.environment)
    managed_by             = "terraform"
    template_family        = "redshift"
    serving_pattern        = "serverless"
  }
}

resource "aws_redshiftserverless_namespace" "ddc_gold" {
  namespace_name        = local.namespace_name
  db_name               = var.database_name
  admin_username        = var.admin_username
  manage_admin_password = true
  iam_roles             = var.iam_role_arns

  tags = merge(local.standard_tags, var.tags)
}

resource "aws_redshiftserverless_workgroup" "ddc_gold" {
  workgroup_name       = local.workgroup_name
  namespace_name       = aws_redshiftserverless_namespace.ddc_gold.namespace_name
  base_capacity        = var.base_capacity
  publicly_accessible  = false
  enhanced_vpc_routing = true

  tags = merge(local.standard_tags, var.tags)
}

variable "aws_region" {
  description = "AWS region for the serving deployment."
  type        = string
  default     = "eu-west-1"
}

variable "project" {
  description = "Short project or platform identifier."
  type        = string
  default     = "adp"
}

variable "environment" {
  description = "Repository environment identifier in lowercase."
  type        = string
  default     = "dev"
}

variable "serving_name" {
  description = "Short serving identifier used in names."
  type        = string
  default     = "redshift-gold"
}

variable "database_name" {
  description = "Serving database name."
  type        = string
  default     = "ddc_gold"
}

variable "admin_username" {
  description = "Administrative username placeholder for the namespace."
  type        = string
  default     = "platform_admin"
}

variable "iam_role_arns" {
  description = "IAM role ARNs attached to the serving namespace."
  type        = list(string)
  default     = []
}

variable "base_capacity" {
  description = "Base capacity for the serving workgroup."
  type        = number
  default     = 32
}

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
