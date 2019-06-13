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

