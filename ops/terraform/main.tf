terraform {
  backend "gcs" {
    bucket = "tf-gcp-gql-tf-state"
    credentials = "~/.terraform/service-account.json"
  }
}

provider "google" {
  credentials = "${file("~/.terraform/service-account.json")}"
  region      = "us-central1"
  project     = "${var.project_id}"
}

provider "google-beta" {
  credentials = "${file("~/.terraform/service-account.json")}"
  region      = "us-central1"
  project     = "${var.project_id}"
}