########################################
# Locals
########################################

locals {
  name = var.project_name
  tags = {
    Project = var.project_name
    Env     = "dev"
    Owner   = "marlon"
  }
}

########################################
# VPC
########################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${local.name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = local.tags
}

########################################
# EKS Cluster
########################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${local.name}-eks"
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = local.tags

  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      disk_size      = 20
      tags           = local.tags
    }
  }

  enable_irsa = true
}

########################################
# ECR Repositories (NO lifecycle policies to avoid errors)
########################################

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.0"

  for_each = toset(var.ecr_repos)

  repository_name = "${local.name}-${each.key}"
  repository_type = "private"

  # Disable lifecycle policies to avoid InvalidParameterException errors
  create_lifecycle_policy = false

  tags = local.tags
}

########################################
# RDS SECURITY GROUP
########################################

resource "aws_security_group" "db_sg" {
  name        = "${local.name}-db-sg"
  description = "DB access from EKS nodes"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Postgres from within VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

########################################
# RDS PostgreSQL
########################################
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "${local.name}-db"

  engine               = "postgres"
  engine_version       = "16.3"
  family               = "postgres16"
  major_engine_version = "16"

  instance_class        = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = "nbastats"
  username = var.db_username
  password = var.db_password

  publicly_accessible = false
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  # 🔥 IMPORTANT FIX — forces RDS into the correct VPC
  create_db_subnet_group = true
  db_subnet_group_name   = "${local.name}-db-subnet-group"
  subnet_ids             = module.vpc.private_subnets

  tags = local.tags
}
