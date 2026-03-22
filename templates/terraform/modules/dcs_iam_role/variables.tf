# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Input variables for a DCS IAM role-only starter module with explicit naming and tagging conventions.

variable "project" {
  description = "Short project or platform identifier used in resource naming."
  type        = string
}

variable "component" {
  description = "Architecture component that owns this resource. Expected values include dcs, isc, dp-eh, dp-sp, or ddc."
  type        = string
}

variable "environment" {
  description = "Repository environment name. Expected values include dit, dev, qa, pprd, or prd."
  type        = string
}

variable "role_purpose" {
  description = "Short role purpose identifier such as glue-job, stepfunctions, or read-only."
  type        = string
}

variable "assume_role_principals" {
  description = "AWS service principals allowed to assume the role."
  type        = list(string)
}

variable "managed_policy_arns" {
  description = "Optional list of managed policy ARNs to attach to the role."
  type        = list(string)
  default     = []
}

variable "inline_policy_json" {
  description = "Optional inline policy document in JSON format."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to merge into the standard repository tag set."
  type        = map(string)
  default     = {}
}
