output "cloud_run_url" {
  description = "The public URL of the deployed Cloud Run service."
  value       = module.application_cloud_run.service_url
}

output "sql_instance_name" {
  description = "The name of the Cloud SQL instance."
  value       = module.datastore_sql.instance_name
}

output "service_account_email" {
  description = "The email address of the application service account."
  value       = module.iam_service_account.service_account_email
}

