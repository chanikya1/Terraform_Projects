provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

resource "google_pubsub_topic" "topic" {
  name = "app-events-topic"
}

resource "google_storage_bucket" "function_bucket" {
  name          = "${var.project_id}-function-code"
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function-code.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "function-code.zip"
}

resource "google_cloudfunctions_function" "subscriber" {
  name                  = "event-subscriber"
  description           = "Triggered by pub/sub to process messages"
  runtime               = "python310"
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_zip.name
  entry_point           = "process_event"
  trigger_http          = false

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.topic.name
  }

  environment_variables = {
    BUCKET_NAME = google_storage_bucket.function_bucket.name
  }

  depends_on = [google_pubsub_topic.topic]
}

resource "google_project_iam_member" "function_pubsub" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "ServiceAccount:${google_cloudfunctions_function.subscriber.service_account_email}"
}

