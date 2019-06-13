terraform {
  required_version = ">= 0.12"
  
  backend "gcs" {
    bucket      = "tf-gcp-gql-10-tf-state"
    credentials = "~/.terraform/service-account.json"
  }
}

provider "google" {
  credentials = file("~/.terraform/service-account.json")
  region      = "us-central1"
  project     = var.project_id
}

provider "google-beta" {
  credentials = file("~/.terraform/service-account.json")
  region      = "us-central1"
  project     = var.project_id
}

provider "kubernetes" {
}

