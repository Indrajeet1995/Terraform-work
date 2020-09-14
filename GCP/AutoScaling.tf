
resource "google_compute_autoscaler" "autosc" {
  provider = google-beta
  name     = "my-autoscaler"
  zone     = "us-central1-a"
  target   = google_compute_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60
  }

}

resource "google_compute_instance_template" "insttemp" {
  provider       = google-beta
  name           = "my-instance-template"
  machine_type   = "n1-standard-1"
  can_ip_forward = false

  disk {
    source_image = data.google_compute_image.debian_9.id
  }

  network_interface {
    network = "default"
  }
}

resource "google_compute_instance_group_manager" "default" {
  provider = google-beta
  name = "my-igm"
  zone = "us-central1-a"
  version {
    instance_template = google_compute_instance_template.insttemp.id
    name              = "primary"
  }
  base_instance_name = "autoscaler-sample"

}

data "google_compute_image" "debian_9" {
  provider = google-beta

  family  = "debian-9"
  project = "debian-cloud"
}
