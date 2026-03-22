# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Input variables for the near-runnable IAM role-only Terraform example used by an ISC Glue runtime pattern.

variable "aws_region" {
  description = "AWS region used for the example deployment."
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

variable "landing_bucket_name" {
  description = "S3 bucket name used by the ISC Glue runtime example."
  type        = string
}
