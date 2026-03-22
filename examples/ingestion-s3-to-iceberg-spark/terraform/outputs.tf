# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Outputs for the ingestion-s3-to-iceberg-spark Terraform starter.

output "isc_landing_bucket_name" {
  description = "ISC Landing Zone bucket name."
  value       = aws_s3_bucket.isc_landing.bucket
}

output "iceberg_warehouse_bucket_name" {
  description = "DP-EH Iceberg warehouse bucket name."
  value       = aws_s3_bucket.platform_warehouse.bucket
}

output "bronze_database_name" {
  description = "Bronze Glue database name."
  value       = aws_glue_catalog_database.bronze.name
}

output "silver_database_name" {
  description = "Silver Glue database name."
  value       = aws_glue_catalog_database.silver.name
}

output "gold_database_name" {
  description = "Gold Glue database name."
  value       = aws_glue_catalog_database.gold.name
}

output "dp_eh_spark_runtime_role_arn" {
  description = "IAM role ARN for the DP-EH Spark runtime."
  value       = module.dp_eh_spark_runtime_role.role_arn
}

output "ddc_athena_workgroup_name" {
  description = "Athena workgroup used for DDC Gold exposure."
  value       = aws_athena_workgroup.ddc_gold.name
}
