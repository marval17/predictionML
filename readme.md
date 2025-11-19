🏀 PredictionML
NBA Game Outcome Prediction Platform — Cloud-Native, ML-Driven, Fully Automated

PredictionML is a cloud-native machine learning platform that collects NBA statistics, trains predictive models, and serves real-time matchup predictions through a modern web interface.
The system is fully containerized, deployed on Kubernetes (EKS), and managed using GitOps and Infrastructure as Code.

This project demonstrates real DevOps, MLOps, cloud engineering, and ML deployment at production scale.

🚀 Overview

PredictionML uses a microservices architecture running on AWS EKS to deliver end-to-end NBA matchup predictions.
The core features include:

Automated data ingestion from NBA API sources

Nightly machine learning model training

Live prediction API endpoint

Web-based frontend for users

Fully automated CI/CD pipeline

Real-time monitoring with Prometheus and Grafana

Infrastructure created entirely with Terraform

🧠 System Architecture
The platform includes:
Infrastructure Layer (Terraform)

AWS VPC

Public + private subnets

NAT gateway

EKS cluster + node groups

RDS PostgreSQL database

ECR registries

IAM roles & security groups

Application Layer (Kubernetes)

frontend – Web UI

prediction-api – ML inference

data-service – ETL/ingestion

ml-jobs – scheduled training tasks

Ingress controller

ArgoCD for GitOps

Prometheus + Grafana monitoring

This design follows cloud-native best practices and mirrors real-world production environments.

🧩 Microservices
🔹 frontend

Interactive web app where users explore NBA predictions.

🔹 prediction-api

Serves ML-powered predictions based on the latest trained model.

🔹 data-service

Collects NBA game and player statistics and loads them into an RDS Postgres database.

🔹 ml-jobs

Nightly Kubernetes CronJob that retrains the model and updates the artifact used by the API.

🔁 Data Flow

Data ingestion: NBA stats → ETL → RDS

Training: CronJob trains updated ML model

Inference: API loads model and returns predictions

UI: Frontend displays win probabilities and game insights

☁️ Infrastructure Overview

All cloud resources are defined using Terraform, making the environment:

Reproducible

Version-controlled

Fully automated

Terraform provisions:

VPC networking

EKS + node groups

RDS Postgres database

ECR registries

IAM + OIDC

Private/public subnets

This forms a production-ready architecture.

🔧 CI/CD Pipeline

PredictionML uses a fully automated pipeline:

CI — GitHub Actions

Builds Docker images

Runs unit tests

Pushes images to AWS ECR

Updates Kubernetes manifests

CD — ArgoCD

Watches GitOps configuration repo

Auto-syncs changes into EKS

Handles rolling deployments

Provides rollback capability

This ensures consistent, zero-downtime deployments.

📈 Monitoring & Observability
Prometheus

Scrapes cluster + service metrics

Collects API latency, model inference metrics, ETL metrics

Tracks CronJob duration

Grafana

Dashboards include:

Cluster health

Pod CPU/Mem

API performance

ML accuracy / latency

Database performance

This gives real-time insight into system performance.