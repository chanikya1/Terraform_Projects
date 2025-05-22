output "function_name" {
  value = google_cloudfunctions_function.subscriber.name
}

output "pubsub_topic" {
  value = google_pubsub_topic.topic.name
}