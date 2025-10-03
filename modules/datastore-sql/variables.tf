variable "project_id" {
  description = "The project ID."
  type        = string
}

variable "region" {
  description = "The region for the Cloud SQL instance."
  type        = string
}

variable "network_id" {
  description = "The self-link of the VPC network."
  type        = string
}

variable "tier" {
  description = "The machine type (tier) for the Cloud SQL instance (e.g., db-f1-micro)."
  type        = string
}

variable "database_version" {
  description = "The database engine and version (e.g., POSTGRES_13)."
  type        = string
}

