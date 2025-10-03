output "service_account_email" {
  description = "The email of the created service account."
  value       = google_service_account.service_account.email
}

output "service_account_id" {
  description = "The unique ID of the created service account."
  value       = google_service_account.service_account.unique_id
}

