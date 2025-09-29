resource "google_sql_database_instance" "instance" {
  project          = var.project_id
  name             = "${var.project_id}-db-instance"
  region           = var.region
  database_version = "POSTGRES_13"
  settings {
    tier = "db-g1-small"
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
