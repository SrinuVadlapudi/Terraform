provider "google" {
project = "siva99"
}

// (VPC Auto)
resource "google_compute_network" "vpc_network" {
name= "vpc-77"
}

// (VPC Custom)

resource "google_compute_network" "default" {
  name  = "main-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub_net" {
  name          = "sub-network"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.default.name
}

resource "google_compute_subnetwork" "vpc_sub" {
  name          = "sub-network-1"
  ip_cidr_range = "10.4.0.0/20"
  region        = "us-west1"
  network       = google_compute_network.default.name
}

// (VM)

resource "google_compute_instance" "vm_instance" {
  name         = "instance-001"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

//  (Disk)

resource "google_compute_disk" "disk" {
  name  = "my-disk"
  image = "debian-cloud/debian-9"
  size  = 50 
  type  = "pd-ssd"
  zone  = "us-central1-a"
}


// (Vpc + Instance-Template + Startuo-script)

resource "google_compute_network" "vpc_name" {
 name  = "raju-20" 
}

resource "google_compute_instance_template" "instance_template" {
  name  = "insta-template-001"
  machine_type = "e2-medium"
  region       = "us-central1"

   disk {
       
   }

  network_interface {
    network = "default"
     }

    
 
   metadata_startup_script = "#! /bin/bash\napt update\napt -y install nginx\ncat <<EOF > /var/www/html/index.nginx-debian.html\n<html><body><p>!!!!!!!!!Welcome to MI Institute!!!!!!!!</p></body></html>"

}  

 // (target-pool)
resource "google_compute_target_pool" "pol" {
  name = "instance"
  region       = "us-central1"

}

	   
//  (Attach-Disk-to-VM)
 resource "google_compute_attached_disk" "attach_disk" {
 disk     = google_compute_disk.disk.name
 instance = google_compute_instance.vm_instance.name
  zone  = "us-central1-a"	 
  }   
	   
	   
	   
