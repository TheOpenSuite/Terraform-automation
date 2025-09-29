resource "google_compute_firewall" "allow_iap" {
  project     = var.project_id
  name        = "${var.project_id}-allow-iap-ssh"
  network     = var.network_name
  direction   = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-secured"]
}
