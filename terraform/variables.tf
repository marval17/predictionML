variable "aws_region" {
    description = "AWS region"
    default = "us-east-1"
}

variable "project_name" {
    description = "project name prefix"
    type = string
    default = "predictionml"
}

variable "vpc_cidr" {
    description = "VPC CIDR block"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    description = "public subnet CIDRS"
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
    description = "private subnet CIRDS"
    type = list(string)
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "eks_cluster_version" {
    description = "EKS control plane vers"
    type = string
    default = "1.30"
}

variable "db_username" {
    description = "RDS database username"
    type = string
    default = "predictionml"
}

variable "db_password" {
    description = "RDS database password"
    type = string
    default = true
}

variable "db_instance_class" {
    description = "RDS instance type"
    type = string
    default = "db.t3.micro"
}

variable "ecr_repos" {
    description = "List of ECR repositories to create"
    type = list(string)
    default = [
      "frontend",
      "prediction-api",
      "data-service",
      "ml-jobs",
    ]
}