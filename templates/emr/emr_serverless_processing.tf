# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Near-runnable Amazon EMR Serverless processing starter for DP-EH or DP-SP Spark workloads over Apache Iceberg-managed data.

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
  name_prefix = "${var.project}-${var.environment}-${var.processing_name}"

  standard_tags = {
    repository             = "aws-data-platform-ai-template"
    architecture_component = upper(var.architecture_component)
    environment            = upper(var.environment)
    managed_by             = "terraform"
    template_family        = "emr"
    processing_pattern     = "emr-serverless"
  }
}

resource "aws_emrserverless_application" "spark_processing" {
  name          = "${local.name_prefix}-spark"
  release_label = var.release_label
  type          = "SPARK"

  maximum_capacity {
    cpu    = var.max_cpu
    memory = var.max_memory
  }

  tags = merge(local.standard_tags, var.tags)
}

variable "aws_region" {
  description = "AWS region for the EMR deployment."
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

variable "architecture_component" {
  description = "Processing owner for this EMR starter. Use dp-eh by default, or dp-sp when a spoke workload is justified."
  type        = string
  default     = "dp-eh"
}

variable "processing_name" {
  description = "Short processing identifier used in names."
  type        = string
  default     = "iceberg-processing"
}

variable "release_label" {
  description = "EMR Serverless release label."
  type        = string
  default     = "emr-7.0.0"
}

variable "max_cpu" {
  description = "Maximum CPU allocated to the EMR Serverless application."
  type        = string
  default     = "16 vCPU"
}

variable "max_memory" {
  description = "Maximum memory allocated to the EMR Serverless application."
  type        = string
  default     = "64 GB"
}

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
