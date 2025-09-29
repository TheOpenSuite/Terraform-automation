resource "google_project" "project" {
  project_id      = var.project_id
  name            = var.project_id
  billing_account = var.billing_account
  labels          = var.labels
}

resource "google_project_service" "apis" {
  for_each                   = toset(var.apis)
  project                    = google_project.project.project_id
  service                    = each.key
  disable_on_destroy         = false
  disable_dependent_services = true
}
