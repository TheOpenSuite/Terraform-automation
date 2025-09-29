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
  default     = "us-central1"
}

variable "iap_support_email" {
  description = "Support email for the IAP consent screen."
  type        = string
}

variable "alert_email" {
  description = "Email for monitoring alerts."
  type        = string
}
