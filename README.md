# GitOps-Based Kubernetes Deployment with ArgoCD

This project demonstrates a complete GitOps workflow for deploying microservices to an EKS cluster using ArgoCD, Terraform, Helm, Docker, and GitLab CI/CD. It follows a multi-environment setup (dev, staging, prod) to ensure production-grade delivery pipelines and infrastructure management.

---

## Project Structure

```bash
project/
├── app/                         # Dockerized microservices
│   ├── frontend/                # Nginx static app
│   └── backend/                 # Flask API service
├── terraform/                   # EKS + IAM + VPC via Terraform
├── helm-charts/                # Helm charts for frontend and backend
├── environments/               # Env-specific values for dev/staging/prod
├── argocd/                      # ArgoCD Application manifests
├── scripts/                     # ArgoCD install scripts
├── .gitlab-ci.yml               # GitLab CI pipeline
└── README.md                    # This file
```

---

## Features

- Provision EKS cluster using modular Terraform
- Dockerized Flask backend and Nginx frontend
- Deploy apps using Helm charts
- Support for dev, staging, prod environments
- GitOps automation with ArgoCD sync and drift detection
- CI/CD pipeline to build and push Docker images to AWS ECR

---

## Infrastructure Provisioning

Terraform modules create the following:
- VPC with public and private subnets
- EKS Cluster + Node Group
- IAM roles for EKS + nodes

Run:
```bash
cd terraform
terraform init
terraform apply
```

---

## Microservices

- Frontend: Static Nginx HTML site
- Backend: Flask API returning JSON message

Both services are Dockerized and built through GitLab CI/CD.

---

## Helm Chart Deployment

Each service has its own Helm chart under `helm-charts/`. Environment-specific values reside in:

```
environments/
├── dev/
├── staging/
└── prod/
```

Example (dev - frontend):
```yaml
replicaCount: 1
image:
  repository: <ecr-url>/frontend
  tag: dev
service:
  type: ClusterIP
  port: 80
```

---

## GitOps with ArgoCD

ArgoCD is used to sync Helm-based services from Git directly to EKS.

Steps:
```bash
bash scripts/install-argocd.sh
kubectl apply -f argocd/frontend-app.yaml
kubectl apply -f argocd/backend-app.yaml
```

Includes automated sync and self-healing:
```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```

---

## GitLab CI/CD

`.gitlab-ci.yml` pipeline stages:
- build_backend
- build_frontend
- push_backend
- push_frontend

Each stage builds Docker images and pushes to AWS ECR using your AWS credentials.

---

## Environments Explained

| Environment | ReplicaCount | ServiceType   | Image Tag |
|-------------|--------------|---------------|------------|
| Dev         | 1            | ClusterIP     | dev        |
| Staging     | 2            | ClusterIP     | staging    |
| Production  | 3            | LoadBalancer  | prod       |

---

## Author
**Harshal Thakur**  
Cloud | DevOps | GitOps | Terraform | Kubernetes | ArgoCD | CI/CD

---

## Final Outcome
Deploy fully automated, environment-specific microservices to EKS with ArgoCD syncing everything straight from Git. Achieve fast rollouts, rollback support, and production-grade reliability.
