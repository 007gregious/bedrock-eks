# Project Bedrock – InnovateMart Retail Store App on Amazon EKS

## Overview

This repository contains the infrastructure code and deployment manifests for Project Bedrock, the inaugural EKS deployment at InnovateMart Inc.

As part of InnovateMart’s modernization initiative, we provisioned an Amazon EKS cluster and deployed the Retail Store Sample App (a microservices-based e-commerce application).

---

## Architecture

- **AWS Region**: us-east-1
- **Networking**: VPC with public/private subnets
- **EKS Cluster**: bedrock-eks
- **Node Group**: EC2 worker nodes running Kubernetes workloads

## IAM & Security

- **ikohsylva** – cluster creator with `system:masters`
- **dev-readonly** – developer IAM user with read-only Kubernetes access

- **Load Balancer**: AWS ELB exposing the app publicly

## Application URL

[`Retail Store Sample App URL`](http://a2544a63767284758a3a011265ee259e-309788396.us-east-1.elb.amazonaws.com/)

---

## Deployment Steps

### Provision Infrastructure (Terraform)

- `terraform init`
- `terraform plan`
- `terraform apply -auto-approve`

This will provision:

- VPC with subnets
- EKS Cluster + Node Group
- IAM roles and policies

### Update kubeconfig

- `aws eks update-kubeconfig \
  --region us-east-1 \
  --name bedrock-eks \
  --profile <your-profile>`

### Deploy Application

- `kubectl apply -f retail-store-sample-app/deploy/`

### Verify

- `kubectl get pods -A`
- `kubectl get svc -A`

---

## Developer Access (Read-Only User)

Developer should use the dev-readonly IAM user.

### Configure AWS CLI

- `aws configure --profile dev-readonly`

### Update Kubeconfig

- `aws eks update-kubeconfig --region us-east-1 --name bedrock-eks --profile dev-readonly`

### Run read-only commands

- `kubectl get pods -A`
- `kubectl describe pod <pod-name>`
- `kubectl logs <pod-name>`

---

## CI/CD (GitHub Actions)

Workflow defined in `.github/workflows/terraform.yml`

- Feature branches → run `terraform plan`
- Main branch → run `terraform apply`

AWS credentials managed securely via GitHub Secrets.

---

## Future Enhancements (Bonus)

- Move databases to AWS RDS & DynamoDB
- Add AWS Load Balancer Controller + Ingress + Route53 + ACM for HTTPS
- Advanced RBAC for developer and QA teams

---
