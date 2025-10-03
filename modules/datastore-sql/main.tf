resource "google_sql_database_instance" "instance" {
  project            = var.project_id
  name               = "${var.project_id}-db-instance"
  region             = var.region
  database_version   = var.database_version 
  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network_id
    }
    backup_configuration {
      enabled = true
    }
  }
  deletion_protection = false # Set to true if in production
}


