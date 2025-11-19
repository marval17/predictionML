output "region" {
  value       = var.aws_region
  description = "AWS region"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "Private subnet IDs"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS API endpoint"
}

output "eks_cluster_ca" {
  value       = module.eks.cluster_certificate_authority_data
  description = "EKS cluster CA data"
}

output "ecr_repositories" {
  value = { for k, repo in module.ecr : k => repo.repository_url }
}

output "db_endpoint" {
  value       = module.db.db_instance_endpoint
  description = "RDS endpoint"
}

output "db_name" {
  value       = module.db.db_instance_name
  description = "RDS database name"
}
