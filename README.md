# Terraform Infrastructure Projects

Welcome! This repository is a collection of infrastructure-as-code projects built using [Terraform](https://developer.hashicorp.com/terraform).

Each project demonstrates how to provision real-world AWS (and potentially other cloud) services in a modular and reproducible way — perfect for learning, practicing, or reusing in your own work.

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS CLI configured (`aws configure`)
- Optional: GitHub and SSH set up if you're cloning via SSH

---

## How to Use

```bash
# Clone the repository
git clone https://github.com/<your-username>/terraform-projects.git
cd terraform-projects

# Navigate into a project
cd 01-fullstack-app-aws

# Follow that project’s README to deploy
terraform init
terraform apply