resource "google_compute_network" "gcp_vpc" {
  name                    = "vpcnetwork"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "gcp_subnet_one" {
  name          = "first-subnetwork"
  ip_cidr_range = "192.168.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.gcp_vpc.id
}

resource "google_compute_subnetwork" "gcp_subnet_two" {
  name          = "second-subnetwork"
  ip_cidr_range = "192.168.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.gcp_vpc.id
}

resource "google_compute_route" "route-ilb" {
  name             = "route-ilb"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.gcp_vpc.name
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_address" "ip-address" {
  name         = "my-address"
  address_type = "EXTERNAL"
}


resource "google_compute_router" "gcp_router" {
  name    = "my-router"
  region  = google_compute_subnetwork.gcp_subnet_one.region
  network = google_compute_network.gcp_vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                   = "my-router-nat"
  router                 = google_compute_router.gcp_router.name
  region                 = google_compute_router.gcp_router.region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.ip-address.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.gcp_subnet_one.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }


}
