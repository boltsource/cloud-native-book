resource "google_project_service" "kubernetes" {
  service = "container.googleapis.com"

  disable_on_destroy         = true
  disable_dependent_services = true
}

resource "google_container_cluster" "kubernetes" {
  name               = "main-cluster"
  depends_on         = [google_project_service.kubernetes]
  initial_node_count = 3
  location           = "us-central1-a"

  master_auth {
    username = ""
    password = ""
  }

  ip_allocation_policy {
    use_ip_aliases = true
  }

  node_config {
    machine_type = "n1-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write", # For Stackdriver Logging
      "https://www.googleapis.com/auth/monitoring", # For Stackdriver Monitoring
      "https://www.googleapis.com/auth/cloud-platform", # For Stackdriver Error Tracking
      "https://www.googleapis.com/auth/trace.append" # For Stackdriver Trace
    ]

    tags = ["gke-cluster"]
  }
}

