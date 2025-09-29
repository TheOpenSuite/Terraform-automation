resource "google_storage_bucket" "bucket" {
  project      = var.project_id
  name         = var.bucket_name
  location     = var.location
  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 # days
    }
  }
}
