# Deploy a Full-Stack App on AWS Using Terraform

This project sets up the full backend infrastructure for a simple full-stack app using **Terraform** and **AWS**. It takes care of everything you typically need — virtual networking, compute, database, storage, and IAM — all as code.

---

## What’s Inside?

Here’s what the project sets up:

- A **VPC** with public subnet and an internet gateway
- An **EC2** instance (Ubuntu-based) with Nginx installed via `user-data.sh`
- An **RDS** PostgreSQL instance
- A **private S3 bucket** with versioning enabled
- An **IAM Role** for EC2 with access to read from the S3 bucket

Everything is modular — each resource type has its own folder under `/modules`.

---

## Prerequisites

Before you start, make sure you have:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS credentials configured (run `aws configure` if you haven’t)
- An existing EC2 key pair in your target AWS region (you’ll need the key name)
- Git installed if you're cloning the repo

---

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/<your-username>/aws-fullstack-app.git
cd aws-fullstack-app
```

### 2. Add your variable values

Edit `terraform.tfvars` with your AWS region and EC2 key pair name:

```hcl
aws_region = "us-east-1"
key_name   = "my-ec2-keypair"
```

> Your key pair must exist in your AWS account under EC2 → Key Pairs.

---

### 3. Initialize the project

Run this once to set up the Terraform provider and download required modules:

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

### 4. Preview what will be created

Check the plan before applying:

```bash
terraform plan
```

### 5. Deploy everything

```bash
terraform apply
```

Terraform will prompt you to confirm — type `yes` to continue.

---

## Accessing the App

Once deployed, the EC2 instance will be running Nginx. You can grab its public IP from the output and visit it in your browser:

```bash
terraform output public_ip
```

Open your browser and go to `http://<that-ip>` — you should see a "Hello from EC2" message.

---

## Cleanup

If you want to destroy all the resources:

```bash
terraform destroy
```

This will remove the VPC, EC2, RDS, S3 bucket, IAM role — everything.

---

## Notes

- RDS is created in a public subnet just for simplicity. For real apps, you’d want it in a private subnet.
- You can customize the EC2 startup by editing `user-data.sh`.
- All AWS services used here fall under the free tier (as long as you stay within limits).