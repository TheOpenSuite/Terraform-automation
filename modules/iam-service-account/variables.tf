variable "project_id" {
  description = "The project ID to create the service account in."
  type        = string
}

variable "account_id" {
  description = "The account ID for the service account."
  type        = string
}

variable "display_name" {
  description = "The display name for the service account."
  type        = string
}

variable "roles" {
  description = "A list of IAM roles to assign to the service account."
  type        = list(string)
  default     = []
}
