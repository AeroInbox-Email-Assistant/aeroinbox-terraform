# AeroInbox Infrastructure as Code (Terraform)

This repository contains the Terraform Infrastructure as Code (IaC) configuration for deploying the AeroInbox platform resources to Azure.

---

## Infrastructure Architecture Overview

AeroInbox is provisioned in a secure, isolated network topology on Azure containing:
* **Azure Kubernetes Service (AKS)**: Private cluster running system (`agentpool`) and user workload (`userpool`) node pools, with KEDA and OpenTelemetry pre-integrated.
* **Azure Key Vault**: Stores application credentials, DB connection strings, and Service Bus access keys securely.
* **Azure Database for PostgreSQL (Flexible Server)**: Backing datastore configured with password auth disabled (AD workload identity authentication only) and public network access blocked.
* **Azure Cache for Redis**: Distributed caching and session layer.
* **Azure Service Bus**: Handles decoupled messaging queue (`meeting-reminders`) between services.
* **Azure Application Gateway (Ingress)**: Public-facing WAF entry point routing to private AKS pods.

---

## Repository Structure

```
aeroinbox-terraform/
+-- environments/
¦   +-- production/
¦   ¦   +-- main.tf             # Production environment deployment
¦   ¦   +-- variables.tf        # Configuration parameters
¦   ¦   +-- terraform.tfvars    # Subcription and region specific inputs
¦   ¦   +-- provider.tf         # Azure Provider definition
¦   +-- dev/
¦       +-- main.tf             # Development environment deployment
¦       +-- variables.tf
+-- modules/                    # Reusable Custom Infrastructure Modules
¦   +-- aks/                    # AKS provisioning and configuration
¦   +-- appgateway/             # Public App Gateway and routing configurations
¦   +-- servicebus/             # Azure Service Bus namespace and queues
¦   +-- keyvault/               # Key Vault and access policies
¦   +-- identity/               # User-assigned managed identities (workload identity)
¦   +-- network/                # Virtual Networks, Subnets, and routing
¦   +-- private-endpoints/      # Private endpoints for DB, KV, and Cache
¦   +-- database/               # PostgreSQL flexible server database
¦   +-- storage/                # State backend storage configs
¦   +-- acr/                    # Container Registry
¦   +-- monitor/                # Log Analytics and Application Insights
¦   +-- resource-group/         # RG container
+-- steps.md                    # Complete Re-provisioning and Disaster Recovery Runbook
```

---

## Workflow & Deployment Commands

See the complete re-provisioning runbook at [`steps.md`](steps.md) for details.

### 1. Azure Authentication
Always authenticate your Azure CLI session before executing Terraform commands:
```bash
az login
az account set --subscription "<your-subscription-id>"
```

### 2. Execution Cycle
Navigate to the target environment directory:
```bash
cd environments/production/
```
Initialize, plan, and apply the workspace:
```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

---

## Observability & Observables

- **Application Insights**: `appi-aeroinbox-production` tracks distributed trace telemetry.
- **Log Analytics**: `log-aeroinbox-production` collects stdout/stderr stream from all pods.
- **Workload Identity Bindings**: Services access Key Vault secrets and the PostgreSQL DB securely using Azure AD Workload Identity federated credentials, eliminating the need to store keys inside code repositories or configs.
