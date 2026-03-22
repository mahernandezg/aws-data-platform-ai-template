# License: Apache 2.0
# Author: Manuel Hernandez Giuliani
# Date Created: 2026-03-22
# Date Modified: 2026-03-22
# Purpose: Outputs for the ingestion-s3-to-redshift-spark Terraform starter.

output "isc_landing_bucket_name" {
  description = "ISC Landing Zone bucket name."
  value       = aws_s3_bucket.isc_landing.bucket
}

output "iceberg_warehouse_bucket_name" {
  description = "DP-EH Iceberg warehouse bucket name."
  value       = aws_s3_bucket.platform_warehouse.bucket
}

output "redshift_stage_bucket_name" {
  description = "Controlled S3 staging bucket used for Redshift loads."
  value       = aws_s3_bucket.redshift_stage.bucket
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

output "ddc_redshift_copy_role_arn" {
  description = "IAM role ARN used by Redshift to read the controlled S3 staging location."
  value       = module.ddc_redshift_copy_role.role_arn
}

output "redshift_namespace_name" {
  description = "Redshift Serverless namespace used for DDC serving."
  value       = aws_redshiftserverless_namespace.ddc_gold.namespace_name
}

output "redshift_workgroup_name" {
  description = "Redshift Serverless workgroup used for DDC serving."
  value       = aws_redshiftserverless_workgroup.ddc_gold.workgroup_name
}
