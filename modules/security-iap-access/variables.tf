variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "network_name" {
  description = "The self-link of the network to apply firewall rules to."
  type        = string
}

variable "iap_support_email" {
  description = "Support email for the IAP consent screen."
  type        = string
}
