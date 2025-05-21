provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

resource "google_compute_network" "vpc_network" {
  name = "webapp-vpc"
}

resource "google_compute_firewall" "default" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_instance_template" "default" {
  name         = "web-template"
  machine_type = "e2-medium"

  tags = ["http-server"]
  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {}
  }
  metadata_startup_script = file("startup-script.sh")
}

resource "google_compute_region_instance_group_manager" "default" {
  name               = "webapp-group"
  region             = var.region
  base_instance_name = "webapp"

  version {
    instance_template = google_compute_instance_template.default
    name              = "v1"
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_global_address" "default" {
  name = "webapp-ip"
}

resource "google_compute_backend_service" "default" {
  name        = "webapp-backend"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = google_compute_region_instance_group_manager.default.instance_group
  }
}

resource "google_compute_url_map" "default" {
  name            = "webapp-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name    = "webapp-http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "webapp-forwarding-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}

resource "google_storage_bucket" "static_assets" {
  name                        = "${var.project_id}-static-assets"
  location                    = var.region
  uniform_bucket_level_access = true
}