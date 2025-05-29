resource "google_compute_network" "secure_vpc" {
  name                    = "secure-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  region        = var.region
  network       = google_compute_network.secure_vpc.id
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_firewall" "allow_ssh_terminal" {
  name    = "allow-ssh-terminal"
  network = google_compute_network.secure_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/16"]
  direction     = "INGRESS"
  priority      = 1000

}

resource "google_project_iam_custom_role" "developer_role" {
  role_id     = "customDeveloper"
  title       = "Custom Developer"
  description = "Custom role with limited dev permissions"
  project     = var.project_id

  permissions = [
    "compute.instances.list",
    "compute.instances.get",
    "storage.buckets.list"
  ]
}

resource "google_project_iam_binding" "bind_developer" {
  project = var.project_id
  role    = google_project_iam_custom_role.developer_role.name

  members = [
    "user:${var.developer_email}"
  ]
}

resource "google_storage_bucket" "audit_logs_bucket" {
  name          = "${var.project_id}-audit-logs"
  location      = var.region
  force_destroy = true
}

resource "google_logging_project_sink" "audit_logs" {
  name                   = "audit-logs"
  destination            = "storage.googleapis.com/${google_storage_bucket.audit_logs_bucket.name}"
  filter                 = "logName:\"logs/cloudaudit.googleapis.com\""
  unique_writer_identity = true
}

resource "google_storage_bucket_iam_member" "sink_writer" {
  bucket = google_storage_bucket.audit_logs_bucket.name
  role   = "roles/storage.objectCreator"
  member = google_logging_project_sink.audit_logs.writer_identity
}

