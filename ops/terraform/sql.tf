resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"

  disable_on_destroy         = true
  disable_dependent_services = true
}

resource "google_project_service" "sqlcomponent" {
  service = "sql-component.googleapis.com"

  disable_on_destroy         = true
  disable_dependent_services = true
}

resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"

  disable_on_destroy         = true
  disable_dependent_services = true
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_container_cluster.kubernetes.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_container_cluster.kubernetes.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.servicenetworking]
}

resource "google_sql_database_instance" "master" {
  provider         = google-beta
  name             = "cloud-sql-v2"
  region           = "us-central1"
  database_version = "POSTGRES_9_6"

  depends_on = [
    google_project_service.sqladmin,
    google_project_service.sqlcomponent,
    google_service_networking_connection.private_vpc_connection,
  ]

  settings {
    tier = "db-g1-small"

    ip_configuration {
      ipv4_enabled    = "false"
      private_network = google_container_cluster.kubernetes.network
    }
  }
}

resource "google_sql_user" "users" {
  name     = var.cloud_sql_username
  instance = google_sql_database_instance.master.name
  password = var.cloud_sql_password
}

resource "google_sql_database" "users" {
  name     = "production"
  instance = google_sql_database_instance.master.name
}

