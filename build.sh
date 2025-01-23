#!/bin/bash

# Variables
cluster_name="eks"
region="eu-west-1" 
aws_id="277707120669"
repo_name="python-img"  
image_name="$aws_id.dkr.ecr.$region.amazonaws.com/$repo_name:latest"
service_name="micro-svr"
namespace="python-app"

#terraform 
cd terraform && \ 
terraform init 
terraform apply -auto-approve
cd ..

# update kubeconfig
echo "--------------------Update Kubeconfig--------------------"
aws eks update-kubeconfig --name $cluster_name --region $region

# remove preious docker images
echo "--------------------Remove Previous build--------------------"
docker rmi -f $image_name || true

# build new docker image with new tag
echo "--------------------Build new Image--------------------"
docker build -t $image_name .


#ECR Login
echo "--------------------Login to ECR--------------------"
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $aws_id.dkr.ecr.$region.amazonaws.com

# push the latest build to dockerhub
echo "--------------------Pushing Docker Image--------------------"
docker push $image_name

# create namespace
echo "--------------------creating Namespace--------------------"
kubectl create ns $namespace || true

# Deploy the application
echo "--------------------Deploy App--------------------"
kubectl apply -n $namespace -f kubernets

# Wait for application to be deployed
echo "--------------------Wait for all pods to be running--------------------"
sleep 60s


# Retrieve and display external IP of services
echo "--------------------Retrieve External IPs--------------------"
services=$(kubectl get svc -n $namespace -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.loadBalancer.ingress[0].ip}{"\n"}{end}')

kubectl get svc -n python-app
