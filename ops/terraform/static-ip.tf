resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_compute_address" "ingress" {
  depends_on = [google_project_service.compute]
  name = "ingress"
}

