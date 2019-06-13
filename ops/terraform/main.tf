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

variable "project_id" {
  type        = string
  description = "The project id on GCP"
}

variable "cloud_sql_username" {
  type        = string
  description = "The username for the cloud sql instance"
  default     = "user"
}

variable "cloud_sql_password" {
  type        = string
  description = "The password for the cloud sql instance"
}

