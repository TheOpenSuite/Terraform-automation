variable "project_id" {
  description = "The project ID."
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}

variable "region" {
  description = "The region for the Cloud Run service."
  type        = string
}

variable "image" {
  description = "The Docker container image to deploy on Cloud Run."
  type        = string
}


