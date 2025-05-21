# GCP Web App Infrastructure with Terraform

This project provisions a complete web application infrastructure on **Google Cloud Platform (GCP)** using **Terraform**.

It sets up:

- A custom **VPC**
- A **managed instance group** of web servers behind an **HTTP Load Balancer**
- A **Cloud Storage** bucket for static assets
- Proper **firewall rules** to allow HTTP traffic

---

## What’s Deployed

| Resource                        | Purpose                                    |
|---------------------------------|--------------------------------------------|
| VPC                             | Isolated network for your infrastructure   |
| Firewall                        | Allows HTTP (port 80) from the internet    |
| Instance Template               | Defines how web servers are configured     |
| Managed Instance Group (2 VMs) | Automatically manages identical VMs        |
| HTTP Load Balancer              | Distributes traffic across VMs             |
| Global Static IP                | Public IP address for the load balancer    |
| Cloud Storage Bucket            | Stores static files or app assets          |

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
git clone https://github.com/<your-username>/gcp-webapp-infra.git
cd gcp-webapp-infra
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