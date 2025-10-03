output "instance_name" {
  description = "The name of the Cloud SQL instance."
  value       = google_sql_database_instance.instance.name
}

output "connection_name" {
  description = "The connection name of the Cloud SQL instance (for SA connections)."
  value       = google_sql_database_instance.instance.connection_name
}

