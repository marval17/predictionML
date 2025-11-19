PredictionML
NBA Game Prediction Platform — Cloud-Native Architecture

PredictionML is a cloud-native machine learning platform that predicts NBA game outcomes using historical and real-time data. The system is built using modern DevOps, MLOps, and cloud engineering practices, including Kubernetes, Terraform, AWS EKS, GitOps, Docker, Prometheus, and Grafana.

This repository contains both the application code and the infrastructure-as-code definitions needed to deploy the entire stack.

1. Overview

PredictionML provides:

Automated ingestion of NBA data

Nightly machine learning model training

Real-time inference through a prediction API

A user-facing web frontend

Fully automated CI/CD using GitHub Actions and ArgoCD

Monitoring and alerting via Prometheus and Grafana

All infrastructure provisioned through Terraform

This project demonstrates real-world, production-grade DevOps and MLOps engineering.

2. Architecture Summary

The platform is composed of four core layers:

Infrastructure (Terraform + AWS)

VPC with public and private subnets

NAT Gateway

EKS cluster and managed node groups

RDS PostgreSQL database

ECR registries for all microservices

IAM roles and OIDC integration

Application Layer (Kubernetes on EKS)

prediction-api — ML inference service

data-service — ETL + ingestion jobs

ml-jobs — scheduled model training

frontend — web UI

Ingress controller for routing

ArgoCD for GitOps-based deployments

Machine Learning

ETL pipeline loads NBA datasets into RDS

Nightly training job produces a model artifact

Inference service loads the latest model for predictions

Monitoring + Observability

Prometheus for metrics collection

Grafana for dashboards

Metrics include API performance, model latency, job status, and cluster health

3. Microservices
frontend

Web application that visualizes predictions and matchup insights.

prediction-api

REST API serving real-time win probability predictions using the latest ML model.

data-service

Collects NBA data from public sources and updates the database.

ml-jobs

Kubernetes CronJob that trains new models on a schedule and stores the updated artifacts.

4. CI/CD Pipeline
Continuous Integration — GitHub Actions

Builds Docker images

Runs automated tests

Pushes images to AWS ECR

Updates Kubernetes manifests

Continuous Deployment — ArgoCD

Watches the GitOps repo

Syncs changes to EKS

Manages rollouts, rollbacks, and version history

This ensures a fully automated, declarative deployment workflow.

5. Infrastructure Deployment

All cloud resources are defined using Terraform.

Deploy infrastructure:
terraform init
terraform apply -var-file="env.tfvars"

Connect to EKS:
aws eks update-kubeconfig --name predictionml-eks --region us-east-1
kubectl get nodes


After the cluster is established, ArgoCD synchronizes application manifests automatically.

6. Project Structure (high-level)
predictionML/
├── terraform/           # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── env.tfvars
├── kubernetes/          # Manifests and GitOps config
├── services/
│   ├── prediction-api/
│   ├── data-service/
│   ├── ml-jobs/
│   └── frontend/
└── README.md

7. Purpose

PredictionML is designed as a portfolio-grade demonstration of:

Cloud-native architecture

Kubernetes operations

Terraform-based infrastructure provisioning

GitOps and CI/CD automation

Machine learning deployment pipelines

Monitoring, observability, and production readiness

This project reflects industry-standard engineering best practices.

8. Status

This project is actively evolving. Additional features, datasets, dashboards, and model improvements are planned.
