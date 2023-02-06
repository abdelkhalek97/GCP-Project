resource "google_compute_firewall" "ssh_firewall" {
  project       = var.project
  name          = var.name
  network       = var.network
  direction     = var.direction
  source_ranges = var.source_ranges

  allow {
    protocol = var.protocol
    ports    = var.ports
  }
}
