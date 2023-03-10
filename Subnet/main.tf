resource "google_compute_subnetwork" "subnet_network" {
  name                     = var.name
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = var.network
  private_ip_google_access = true
}