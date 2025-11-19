# PredictionML — NBA Game Prediction Platform

End-to-end cloud-native machine learning platform that ingests NBA data, trains predictive models, deploys microservices on Amazon EKS, and exposes a real-time prediction API and web dashboard. Infrastructure is fully automated using Terraform, GitOps with ArgoCD, and monitored using Prometheus + Grafana.

┌────────────┐
│   INGEST   │ → Automated NBA data collection (API → S3 → RDS)
└──────┬─────┘
       │
┌──────▼──────┐
│  TRAINING    │ → Nightly ML training jobs (Kubernetes CronJobs)
└──────┬──────┘
       │
┌──────▼─────────┐
│  PREDICT API    │ → Real-time inference microservice
└──────┬─────────┘
       │
┌──────▼──────────────┐
│   FRONTEND APP       │ → User-facing prediction dashboard
└──────┬──────────────┘
       │
┌──────▼──────────────┐
│ PROMETHEUS/GRAFANA  │ → Metrics, dashboards, alerts
└─────────────────────┘

📁 Repository Layout
Path	Description
terraform/	Terraform IaC for VPC, subnets, NAT gateway, EKS cluster, node groups, RDS, ECR.
services/	Prediction API, Data API, ML training jobs, and frontend microservices.
k8s/	Kubernetes manifests for Deployments, Services, Ingress, CronJobs, Secrets, ConfigMaps.
argo/	ArgoCD GitOps Application definitions for auto-sync deployments.
monitoring/	Prometheus + Grafana dashboards, scrape configs, alerting rules.
docker/	All Dockerfiles for the platform.
.github/workflows/	CI pipelines for build, lint, test, Docker push, and image validation.

🔄 Workflow
1. Ingest Data

Pull NBA game & player stats from a public API

Store raw data in S3

Write structured data to PostgreSQL (RDS)

2. Train Machine Learning Model

Nightly Kubernetes CronJob

Generates updated model artifacts

Stores model in S3 or a model registry

3. Deploy Microservices

Prediction API

Data API

Frontend dashboard

Automated rollout via ArgoCD GitOps

4. Monitor the Platform

Prometheus scrapes system + app metrics

Grafana visualizes dashboards for cluster, APIs, and prediction performance

Alerts can be configured via Alertmanager

🚀 Getting Started
1. Deploy Infrastructure

Requires Terraform 1.6+ and AWS credentials.

cd terraform/
terraform init
terraform apply -var-file="env.tfvars"


This provisions:

VPC, routes, subnets

NAT Gateway

Amazon EKS

RDS PostgreSQL

ECR repositories

2. Build and Push Docker Images
docker build -t prediction-api ./services/prediction-api
docker push <ECR_URL>/prediction-api


Repeat for:

data-service

ml-jobs

frontend

3. Apply Kubernetes Manifests
kubectl apply -f k8s/

4. Enable GitOps with ArgoCD

Install ArgoCD

Connect GitHub repo

Enable auto-sync

Your cluster will now auto-deploy on every git push.

5. Launch Monitoring Stack
kubectl apply -f monitoring/prometheus/
kubectl apply -f monitoring/grafana/


Grafana dashboards include:

EKS node metrics

API latency & throughput

Model prediction frequency

CronJob training summaries

🗺️ Roadmap

 VPC networking + NAT + routing

 EKS cluster & node groups

 RDS PostgreSQL

 ECR repositories

 NBA ingestion pipeline

 ML model training workflow

 Real-time prediction API

 Frontend prediction dashboard

 Full GitOps deployment via ArgoCD

 Prometheus/Grafana dashboards

 Production hardening (IAM, SSL, rate limits)
