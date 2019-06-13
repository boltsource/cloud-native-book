resource "google_project_service" "memorystore" {
  service                     = "redis.googleapis.com"
  disable_on_destroy          = true
  disable_dependent_services  = true
}

resource "google_redis_instance" "memorystore" {
  name            = "cloud-memorystore"
  tier            = "BASIC"
  memory_size_gb  = 1
  depends_on      = [google_project_service.memorystore]
  location_id     = "us-central1-a"
}

