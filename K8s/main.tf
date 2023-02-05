resource "google_container_cluster" "private_cluster" {
  name                     = var.clusterName
  location                 = var.location
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network
  subnetwork               = var.subnetwork

  node_locations = var.node_locations

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.cidr_block
      display_name = var.display_name
    }
  }

  ip_allocation_policy {

  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

}

resource "google_container_node_pool" "nodepool" {
  name       = var.nodeName
  cluster    = google_container_cluster.private_cluster.id
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform" 
    ] 
  }
}