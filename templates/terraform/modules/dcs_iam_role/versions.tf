# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: DCS starter Terraform module for creating one role-based access pattern with consistent naming and tagging.

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
