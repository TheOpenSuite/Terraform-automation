variable "project_id" {
  description = "The project ID from which to export logs."
  type        = string
}

variable "log_destination_project_id" {
  description = "The project ID where logs will be sent."
  type        = string
}
