output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}


output "cluster_id" {
  value = aws_eks_cluster.eks.id
}

output "node_group_id" {
  value = aws_eks_node_group.node-group.id
}


output "fsubnet_ids" {
  value = aws_subnet.first_subnet.id
}

output "Ssubnet_ids" {
  value = aws_subnet.second_subnet.id
}


output "cluster_token" {
  value = data.aws_eks_cluster_auth.eks.token
  sensitive = true
}

output "ec2" {
  value = aws_instance.jenkins.public_ip
}


#utput "private_ip" {
#  value = aws_instance.node_group_instances[*].private_ip
#c}