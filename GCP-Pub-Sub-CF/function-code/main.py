import base64
import os
from google.cloud import storage

def process_event(event, context):
    message = base64.b64decode(event['data']).decode('utf-8')
    print(f"Receivedmessage: {message}")

    bucket_name = os.environ.get("BUCKET_NAME")
    client = storage.client()
    bucket = client.get_bucket(bucket_name)
    blob = bucket.blob(f"event-{context.event_id}.txt")
    blob.upload_from_string(message)
    print(f"Saved message to {blob.name} in bucket {bucket_name}")
else:
    print("No data in event")