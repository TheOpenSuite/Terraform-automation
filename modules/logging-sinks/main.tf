resource "google_logging_project_sink" "sink" {
  project                     = var.project_id
  name                        = "centralized-log-sink"
  destination                 = "logging.googleapis.com/projects/${var.log_destination_project_id}/locations/global/buckets/_Default"
  filter                      = "severity >= WARNING"
  unique_writer_identity      = true
}

resource "google_project_iam_member" "log_writer" {
  count      = 1 
  project    = var.log_destination_project_id
  role       = "roles/logging.logBucketWriter"
  member     = google_logging_project_sink.sink.writer_identity
  depends_on = [google_logging_project_sink.sink] 
}


