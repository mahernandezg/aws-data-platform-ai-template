# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Outputs for the DCS IAM role-only starter module.

output "role_name" {
  description = "Created IAM role name."
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "Created IAM role ARN."
  value       = aws_iam_role.this.arn
}
