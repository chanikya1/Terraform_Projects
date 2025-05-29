# Secure GCP Networking and IAM Setup using Terraform

This project automates the setup of a secure and scalable GCP networking environment with IAM configurations using **Terraform**. It provisions:
- A custom VPC with public and private subnets
- Firewall rules for internal SSH access
- Custom IAM roles and bindings
- Audit logging configuration using a logging sink and a storage bucket

---

## Key Features

- **Custom VPC** with separate public and private subnets
- **Internal-only SSH firewall rules**
- **Custom IAM Role** with least privilege
- **IAM Binding** for a specific developer account
- **Cloud Audit Logs** sink to a GCS bucket
- Modular, reusable Terraform setup

---

## Benefits of This Project

Demonstrates secure-by-design infrastructure
Automates IAM and reduces manual errors
Shows real-world multi-subnet architecture
Aligns with Google Cloud security best practices

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
git clone https://github.com/<your-username>/gcp-network-and-iam.git
cd gcp-network-and-iam
```

### 2. Initialize Terraform

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

### 3. Review and apply the infrastructure

```bash
terraform plan
terraform apply
```

Type `yes` to confirm the deployment.

---

## Cleanup

To delete all resources:

```bash
terraform destroy
```