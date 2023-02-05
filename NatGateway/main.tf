resource "google_compute_router_nat" "nat_getway" {
  name  = var.NatName
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name = var.SubName
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


resource "google_compute_router" "router" {
  name = var.RouterName
  network = var.network
  region = var.RouterRegion
}
