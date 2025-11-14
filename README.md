## Overview

### This Terraform project provisions a scalable and fault-tolerant EC2 infrastructure on AWS.
It automatically creates:

  - VPC, Subnet, and Internet Gateway
  - Security Group allowing SSH (22) and HTTP (80)
  - Launch Template for EC2 configuration
  - Auto Scaling Group (ASG) that manages multiple EC2 instances
  - Custom user (devopsadmin) with full sudo access
  - Pre-installed Nginx web server
---

## Architecture Diagram
```
          ┌───────────────────────────────┐
          │          Internet             │
          └──────────────┬────────────────┘
                         │
                 HTTP :80 │
                         │
         ┌───────────────┴────────────────┐
         │        EC2 Auto Scaling         │
         │          Group (ASG)            │
         │---------------------------------│
         │  - Launch Template (Ubuntu)     │
         │  - Security Group (SSH + HTTP)  │
         │  - Nginx Web Server Installed   │
         └───────────────┬────────────────┘
                         │
                  ┌──────┴──────┐
                  │     VPC     │
                  └─────────────┘

```
---
## Modules Used
### Module	Description
  - VPC	Creates VPC, Subnet, and Internet Gateway
  - Security Group	Allows inbound SSH and HTTP traffic
  - EC2 ASG	Creates Launch Template and Auto Scaling Group

---
## Project Structure
```
terraform-ec2-asg-prod/
│
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
│
├── modules/
│   ├── vpc/
│   ├── security_group/
│   └── ec2_asg/
│
└── README.md

```
---
## Prerequisites
  - Terraform ≥ 1.3
  - AWS Account with IAM credentials configured
  - SSH Key Pair created in AWS
  - Basic knowledge of Terraform and AWS
---
## Configuration
Update ``` terraform.tfvars ``` before running:
```
region        = "ap-south-1"
vpc_cidr      = "10.0.0.0/16"
instance_type = "t2.micro"
key_name      = "my-keypair"

```
 - Make sure the key pair ```my-keypair.pem``` exists in AWS and locally for SSH access.
---
## Deployment Steps

1️ Initialize Terraform
```
terraform init
```

2️ Preview the Plan
```
terraform plan
```

3️ Apply Configuration
```
terraform apply -auto-approve
```

Terraform will:

  - Create a new VPC, Subnet, and Internet Gateway
  - Set up a Security Group
  - Create a Launch Template with your EC2 configuration
  - Deploy an Auto Scaling Group with 1–3 instances
  - Automatically install Nginx and create ```devopsadmin``` user
---
## Connect to EC2 Instance
Find the public IP of an instance:
Option 1 — AWS Console
  - Go to EC2 → Instances and copy the Public IPv4 address.
SSH into EC2
```
ssh -i my-keypair.pem ubuntu@<EC2_PUBLIC_IP>

```
Switch to your custom user:
```
sudo su - devopsadmin
```
---
## Verify Nginx

Once logged in:
```
curl localhost
```

You should see:
```
<h1>Production Terraform EC2 + ASG</h1>
```

Or, open in browser:
```
http://<EC2_PUBLIC_IP>
```
---
## Destroy Infrastructure

To remove everything:
```
terraform destroy -auto-approve
```
