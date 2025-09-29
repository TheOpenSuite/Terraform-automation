variable "project_id" {
  description = "The project ID where the VPC will be created."
  type        = string
}

variable "region" {
  description = "The region for the subnetwork."
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnetwork."
  type        = string
  default     = "10.0.0.0/24"
}
