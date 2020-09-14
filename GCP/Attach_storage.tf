
resource "google_compute_instance" "default" {
  name         = "gcpinst"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size  = 10
    }
  }
  
  network_interface {
    network = "default"
  }
}

  
resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  size  = 10
  image = "debian-9"
  physical_block_size_bytes = 4096

}


resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.default.id
}
