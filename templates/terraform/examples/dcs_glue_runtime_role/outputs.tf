# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Outputs for the near-runnable IAM role-only Terraform example.

output "runtime_role_name" {
  description = "Created IAM role name for the example."
  value       = module.isc_glue_runtime_role.role_name
}
