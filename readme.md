orm

End-to-end cloud-native machine learning platform that ingests NBA data, trains predictive models, deploys microservices on Kubernetes (EKS), and provides a real-time prediction API and web frontend. All infrastructure is automated using Terraform, GitOps via ArgoCD, and monitored with Prometheus + Grafana.

pgsql
Copy code
┌────────────┐
│   INGEST   │ → Automated NBA data collection (API → S3 → RDS)
└──────┬─────┘
       │
┌──────▼──────┐
│   TRAINING   │ → Nightly ML model jobs on Kubernetes
└──────┬──────┘
       │
┌──────▼─────────┐
│   PREDICT API   │ → Real-time inference microservice
└──────┬─────────┘
       │
┌──────▼──────────────┐
│     FRONTEND APP     │ → User-facing prediction dashboard
└──────┬──────────────┘
       │
┌──────▼─────────────┐
│ PROMETHEUS/GRAFANA │ → Metrics, dashboards, alerts
└────────────────────┘
Repository Layout
Path	Description
terraform/	Terraform configs for VPC, subnets, NAT gateway, EKS cluster, node groups, RDS database, and ECR repos.
services/	All microservices: prediction-api, data-service, ML training jobs, and frontend.
k8s/	Kubernetes manifests for Deployments, Services, Ingress, Secrets, CronJobs, and ConfigMaps.
argo/	GitOps application definitions for ArgoCD auto-sync.
monitoring/	Prometheus + Grafana dashboards, scraping rules, alerting config.
docker/	Dockerfiles for all microservices.
.github/workflows/	CI pipelines for lint, build, test, Docker build/push, and GitOps sync.

Workflow
Ingest Data

Pull NBA stats from a public API

Store raw data in S3

Write structured data to PostgreSQL (RDS)

Train ML Model

Nightly Kubernetes CronJob

Generates updated model artifacts

Pushes model to S3 or a model registry

Deploy Microservices

Prediction API

Data API

Frontend web application

Automatically deployed to EKS via ArgoCD

Monitor Everything

Prometheus scrapes cluster + app metrics

Grafana dashboards visualize predictions, latency, cluster health

Alerts can be configured via Alertmanager

Getting Started
Provision Infrastructure

Requires Terraform 1.6+ and AWS credentials

bash
Copy code
cd terraform/
terraform init
terraform apply -var-file="env.tfvars"
Build & Push Docker Images

bash
Copy code
docker build -t prediction-api ./services/prediction-api
docker push <ECR_URL>/prediction-api
Deploy Kubernetes Resources

bash
Copy code
kubectl apply -f k8s/
Enable GitOps with ArgoCD

Install ArgoCD in the cluster

Connect repo

Watch auto-sync deployments

Launch Monitoring Stack

bash
Copy code
cd monitoring/
kubectl apply -f prometheus/
kubectl apply -f grafana/
Roadmap
 VPC, subnets, NAT, and networking foundation

 EKS cluster with managed node groups

 RDS PostgreSQL instance

 ECR repos for all microservices

 Data ingestion pipeline

 ML model training CronJob

 Real-time prediction API

 Frontend dashboard

 Full GitOps delivery with ArgoCD

 Prometheus & Grafana monitoring dashboards

 Production hardening (IAM boundaries, SSL, rate limits)
