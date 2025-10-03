variable "project_id" {
  description = "The desired ID for the new GCP project."
  type        = string
}

variable "billing_account" {
  description = "The billing account ID to link to the project."
  type        = string
}

variable "labels" {
  description = "A map of labels to apply to the project."
  type        = map(string)
  default     = {}
}

variable "apis" {
  description = "A list of APIs to enable on the project."
  type        = list(string)
  default     = []
}

variable "region" {
  description = "The primary GCP region for resources."
  type        = string
  default     = "eu-west3"
}

variable "iap_support_email" {
  description = "Support email for the IAP consent screen."
  type        = string
}

variable "alert_email" {
  description = "Email for monitoring alerts."
  type        = string
}

variable "network_cidr" {
  description = "The CIDR block for the primary VPC subnetwork."
  type        = string
}

variable "service_account_id" {
  description = "The account ID for the application runner service account."
  type        = string
}

variable "cloud_run_image" {
  description = "The Docker image URL for the Cloud Run service."
  type        = string
}

variable "sql_tier" {
  description = "The machine type (tier) for the Cloud SQL instance."
  type        = string
}

variable "sql_database_version" {
  description = "The database engine and version for Cloud SQL (e.g., POSTGRES_13)."
  type        = string
}

variable "secret_password" {
  description = "The sensitive data (database password) to store in Secret Manager."
  type        = string
  sensitive   = true
}
