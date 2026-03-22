# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Input variables for the ingestion-s3-to-iceberg-spark Terraform starter.

variable "aws_region" {
  description = "AWS region for the example deployment."
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

variable "use_case" {
  description = "Short use-case identifier used in names."
  type        = string
  default     = "s3-iceberg-spark"
}
