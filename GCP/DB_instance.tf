provider "google" {
  credentials = file("service-details.json")
  project     = "feisty-access-284613"
  region      = "us-central1"
  zone        = "us-central1-a"
}


resource "google_sql_database_instance" "db_inst" {
  name             = "master-instance"
  region           = "us-central1"

  settings {
    tier = "db-n1-standard-1"
  }
}
