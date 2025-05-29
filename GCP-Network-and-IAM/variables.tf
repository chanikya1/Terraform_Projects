variable "project_id" {
  description = "This is the GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "developer_email" {
  description = "Email for IAM binding"
  type        = string
}