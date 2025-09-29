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
