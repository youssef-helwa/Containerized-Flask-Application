# Micro-Deploy: Python Flask Microservices Deployment on AWS with Terraform and Kubernetes

## Overview
Micro-Deploy is a fully automated CI/CD pipeline designed to deploy a Python Flask microservices application on AWS. The project utilizes Terraform for infrastructure as code (IaC), Kubernetes (EKS) for container orchestration, Jenkins for CI/CD automation, and AWS ECR for container image storage.

## Project Components
### 1. Infrastructure as Code (Terraform)
Terraform is used to provision AWS resources, including:
- EC2 instance for Jenkins
- Amazon EKS cluster
- IAM roles and policies
- VPC, subnets, security groups
- ECR repository for Docker images

### 2. Kubernetes Deployment
Kubernetes manifests define the application deployment and services:
- Deployment with 2 replicas
- LoadBalancer service to expose the application
- Namespace management

### 3. Docker
A Dockerfile is provided to containerize the Flask application:
- Uses `python:3.11-slim` as the base image
- Installs dependencies from `requirements.txt`
- Exposes port 5000

### 4. CI/CD Pipeline (Jenkins)
A Jenkinsfile automates the build and deployment process:
- Builds and pushes the Docker image to AWS ECR
- Updates Kubernetes configurations
- Deploys the application to EKS
- Waits for the deployment to complete

## Prerequisites
- AWS account with necessary permissions
- Terraform installed (`>=1.0.0`)
- Docker installed (`>=20.10`)
- Kubernetes CLI (`kubectl`)
- AWS CLI configured with appropriate credentials
- Jenkins with required plugins installed

## Deployment Steps
### 1. Infrastructure Setup
Run the Terraform script to provision AWS resources:
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

### 2. Build and Push Docker Image
```sh
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $aws_id.dkr.ecr.$region.amazonaws.com
docker build -t $aws_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest .
docker push $aws_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest
```

### 3. Deploy to Kubernetes
```sh
kubectl create namespace $namespace || true
kubectl apply -n python-app -f kubernets/
```

### 4. Verify Deployment
```sh
kubectl get pods -n $namespace
kubectl get svc -n $namespace
```

## Jenkins CI/CD Pipeline
### Configure Jenkins
1. Add AWS credentials to Jenkins
2. Set up a new pipeline project
3. Use the provided `Jenkinsfile`

### Run the Pipeline
Once the pipeline is configured, trigger a build to automate deployment.

## Outputs
- EKS Cluster Name: `${eks_cluster_name}`
- Load Balancer URL: Retrieved from `kubectl get svc -n $namespace`
- Jenkins EC2 Public IP: `${ec2}`

## Cleanup
To delete all resources, run:
```sh
cd terraform
terraform destroy -auto-approve
```
