# GCP Event-Driven Architecture Using Cloud Pub/Sub and Cloud Functions

---

## What This Project Does

This project sets up an event-driven system where:

1. A message is published to a Cloud Pub/Sub topic (e.g., from an app or webhook).
2. That message triggers a Cloud Function.
3. The function processes the data and writes it to a Cloud Storage bucket or a BigQuery table (your choice).

---

## GCP Services Used 

| Service             | Purpose                                    |
| ------------------- | ------------------------------------------ |
| **Cloud Pub/Sub**   | Acts as the message queue (event trigger)  |
| **Cloud Functions** | Executes serverless code when event occurs |
| **Cloud Storage**   | (Optional) Stores processed messages       |
| **BigQuery**        | (Optional) For analytics use case          |
| **IAM**             | Roles and permissions for the function     |

---

## Usecase Example

1. A user uploads JSON log data to an app
2. Your app publishes it to Pub/Sub
3. Pub/Sub triggers the function
4. The function parses it and saves it to Cloud Storage or BigQuery

---

## Prerequisites

Make sure you have:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- A GCP project with billing enabled
- A GCP service account key (JSON)
- `gcloud` CLI set up (optional but helpful)

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/gcp-pub-sub-cf.git
cd gcp-pub-sub-cf
```

### 2. Create and provide your `terraform.tfvars`

```hcl
project_id        = "your-gcp-project-id"
region            = "us-central1"
credentials_file  = "key.json"
```

### 3. Initialize Terraform

```bash
terraform init
```

## Optional Checks Before You Apply

It's a good idea to run these checks to catch mistakes early:

```bash
# Validate your configuration syntax
terraform validate

# Format your Terraform files
terraform fmt 
```

### 4. Review and apply the infrastructure

```bash
terraform plan
terraform apply
```

Type `yes` to confirm the deployment.

---

## Access Your Load Balanced Web App

After deployment:

```bash
terraform output load_balancer_ip
```

Copy the IP and open it in your browser:
```
http://<load_balancer_ip>
```

---

## Cleanup

To delete all resources:

```bash
terraform destroy
```