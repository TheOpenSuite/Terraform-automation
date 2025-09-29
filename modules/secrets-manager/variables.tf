variable "project_id" {
  description = "The project ID."
  type        = string
}

variable "secret_id" {
  description = "The ID of the secret."
  type        = string
}

variable "secret_data" {
  description = "The data to store in the secret."
  type        = string
  sensitive   = true
}

variable "service_account_member" {
  description = "The service account member (e.g., 'serviceAccount:email@...iam.gserviceaccount.com') that can access the secret."
  type        = string
}
