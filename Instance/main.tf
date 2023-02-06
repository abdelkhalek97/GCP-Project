resource "google_compute_instance" "private-vm" {
  name         = var.name
  machine_type = "e2-micro"
  zone         = var.zone

  metadata_startup_script = var.file

  service_account {
    email = var.service_account
    scopes = ["https://www.googleapis.com/auth/cloud-platform" ]
  }
  
  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
    }
  }
 
  network_interface {
    network = var.network
    subnetwork = var.subnetwork
  }

}