provider "google" {
 
  project = "veera9"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_instance" "vm-instance" {
  name         = "test-01"
  machine_type = "f1-micro"



  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
    
  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral IP
    }
  }
}
 resource "google_compute_network" "vpc_network"  {
  name = "vpc-test01"
 } 
 

