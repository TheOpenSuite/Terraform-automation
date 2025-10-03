output "vpc_self_link" {
  description = "The self link of the VPC network."
  value       = google_compute_network.vpc_network.self_link
}

output "vpc_id" {
  description = "The ID of the VPC network."
  value       = google_compute_network.vpc_network.id
}

output "vpc_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.vpc_network.name
}

