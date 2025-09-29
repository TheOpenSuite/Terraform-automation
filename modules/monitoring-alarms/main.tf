resource "google_monitoring_notification_channel" "email" {
  project      = var.project_id
  display_name = "Email Alert"
  type         = "email"
  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_alert_policy" "high_cpu_utilization" {
  project      = var.project_id
  display_name = "High CPU Utilization"
  combiner     = "OR"
  conditions {
    display_name = "VM Instance - High CPU Utilization"
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  notification_channels = [google_monitoring_notification_channel.email.name]
}
