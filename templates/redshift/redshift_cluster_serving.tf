# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Near-runnable Amazon Redshift provisioned cluster serving starter for DDC Gold-serving workloads.

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
  name_prefix = "${var.project}-${var.environment}-${var.serving_name}"

  standard_tags = {
    repository             = "aws-data-platform-ai-template"
    architecture_component = "DDC"
    environment            = upper(var.environment)
    managed_by             = "terraform"
    template_family        = "redshift"
    serving_pattern        = "provisioned-cluster"
  }
}

resource "aws_redshift_cluster" "ddc_gold_serving" {
  cluster_identifier   = "${local.name_prefix}-cluster"
  database_name        = var.database_name
  master_username      = var.admin_username
  manage_master_password = true
  node_type            = var.node_type
  cluster_type         = var.cluster_type
  number_of_nodes      = var.number_of_nodes
  iam_roles            = var.iam_role_arns
  encrypted            = true
  publicly_accessible  = false
  skip_final_snapshot  = var.skip_final_snapshot

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
  description = "Administrative username placeholder for the cluster."
  type        = string
  default     = "platform_admin"
}

variable "node_type" {
  description = "Redshift node type."
  type        = string
  default     = "ra3.xlplus"
}

variable "cluster_type" {
  description = "Cluster type."
  type        = string
  default     = "single-node"
}

variable "number_of_nodes" {
  description = "Number of nodes when multi-node is used."
  type        = number
  default     = 1
}

variable "iam_role_arns" {
  description = "IAM role ARNs attached to the serving cluster."
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot on destroy in this starter."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
