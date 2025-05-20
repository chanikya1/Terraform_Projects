# NGINX Load Balancer on AWS using Terraform

This project sets up an **NGINX-based load balancer** on AWS EC2 that distributes traffic across multiple backend application servers. It's a basic but production-minded setup designed to demonstrate horizontal scaling using reverse proxy logic.

---

## What It Deploys

- A **VPC** with public subnet and internet gateway
- One **NGINX EC2 instance** acting as a load balancer
- Two **EC2 backend app servers** running on private IPs
- **Security groups** to allow traffic between components

Everything is modular each resource type has its own folder under `/modules`.

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

### 4. Preview what will be created

Check the plan before applying:

```bash
terraform plan
```

---

## Optional Checks Before You Apply

It's a good idea to run these checks to catch mistakes early:

```bash
# Format your Terraform files
terraform fmt 

# Validate your configuration syntax
terraform validate
```

### 5. Deploy everything

```bash
terraform apply
```

Terraform will prompt you to confirm type `yes` to continue.

---

## Access the Load Balancer

After deployment, grab the public IP of the NGINX instance:

```bash
terraform output lb_public_ip
```

Then visit it in your browser:
```
http://<lb_public_ip>
```

---

## Clean Up

```bash
terraform destroy
```

---

## What's in the NGINX Config?

The load balancer forwards all requests to two backend app servers using their private IPs via this config:

```nginx
upstream app_servers {
    server 10.0.1.101:3000;
    server 10.0.1.102:3000;
}
server {
    listen 80;
    location / {
        proxy_pass http://app_servers;
    }
}
```

## Here’s what happens when someone opens your NGINX public IP in the browser:

Absolutely! Let’s walk through **Step 1: The Full Request Lifecycle** in a very clear, step-by-step format no code, no arrows just plain human explanation:

---

## What Happens When a User Visits Your NGINX Load Balancer

### Step 1: The User Makes a Request

* A person opens their browser and types in `http://<public-ip-of-nginx-ec2>`.
* This is a request to your **NGINX Load Balancer EC2 instance**.

---

### Step 2: AWS Routes the Request

* The browser’s request hits the **public IP address** of your NGINX EC2.
* AWS routes this request through your **Internet Gateway** into the **VPC and public subnet** where your EC2 instance lives.

---

### Step 3: NGINX Receives the Request

* The NGINX service (running on your EC2) listens on **port 80**.
* It gets the request and checks its configuration file (`nginx.conf`) to decide what to do with it.

---

### Step 4: NGINX Forwards the Request to a Backend

* Inside its config, NGINX has a list of **backend servers** (your app EC2 instances).
* NGINX picks one of them (usually round-robin) and **forwards the request** to that app server’s **private IP** on **port 3000**.

---

### Step 5: App Server Processes the Request

* The app EC2 receives the request and runs your app (e.g., Node.js, Flask, Express).
* The app returns a response something like "Hello from App Server 1".

---

### Step 6: NGINX Gets the Response

* NGINX gets the response from the app server.
* It **acts like a middleman**, taking the app’s reply and preparing it to send back to the user.

---

### Step 7: NGINX Sends the Response to the User

* NGINX sends the response back over the internet to the original user’s browser.
* The user sees the content in their browser from the app server, via NGINX.

---

### Bonus: If the User Refreshes…

* The next request might go to the **second app server**, depending on your load balancing rules.
* This way, NGINX helps **share the traffic** evenly between all your backend servers.

---

## NGINX keeps switching between app servers (round-robin by default) to balance the load.

## How NGINX Decides Where to Forward Traffic

upstream app_servers {
    server 10.0.1.101:3000;
    server 10.0.1.102:3000;
}

server {
    listen 80;
    location / {
        proxy_pass http://app_servers;
    }
}

Here’s how NGINX interprets this:

upstream app_servers { ... }
This block creates a pool of servers. NGINX says:

"Okay, I know where to send traffic: to one of these two servers."

By default, it uses round-robin:

Request 1 → server 1

Request 2 → server 2

Request 3 → server 1 again
... and so on.

You can change this behavior with options like:

least_conn → go to the server with the fewest active connections

ip_hash → same client IP always hits the same server (for sticky sessions)

proxy_pass http://app_servers;
When a user visits http://<nginx-ip>/, NGINX forwards that request to the backend pool picked from the upstream list.

It acts like a middleman:

Receives the request

Sends it to a backend

Waits for the reply

Sends it back to the user

## Example

Imagine your app servers are running this:

res.send("Hello from App Server 1")

and the second:

res.send("Hello from App Server 2")

When you refresh the browser, you’ll alternate between those responses that’s how you see load balancing in action.