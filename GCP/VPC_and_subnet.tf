provider "google" {
  credentials = file("File_name.json")
  project     = "Project_name"
  region      = "us-central1"
  zone        = "us-central1-a"
}



resource "google_compute_network" "gcp_vpc" {
  name = "vpcnetwork"
}

resource "google_compute_subnetwork" "gcp_subnet" {
  name          = "first-subnetwork"
  ip_cidr_range = "192.168.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.gcp_vpc.id
}

resource "google_compute_instance" "gcp_vm" {
  name         = "assignment1"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.gcp_subnet.id
  }
}
