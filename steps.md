# AeroInbox Complete Re-provisioning & Deployment Runbook

This guide covers the end-to-end steps to destroy, re-create, and deploy the AeroInbox infrastructure and application.

---

## Step 1: Pre-requisites & Local Authentication

Before running Terraform commands locally, authenticate your Azure CLI session:

```bash
# 1. Login to Azure
az login

# 2. Select the target Subscription (replace with your active subscription ID)
az account set --subscription 65bf2554-8090-4538-9c38-8a6e9c5f6f22
```

---

## Step 2: GitHub Repository Secrets Configuration

Before triggering any GitHub Actions pipelines, ensure the following repository secrets are configured in the `aeroinbox-app` repository on GitHub:

| GitHub Secret Name | Description / Value |
| :--- | :--- |
| `SONAR_TOKEN` | Token for SonarCloud code quality scans |
| `SNYK_TOKEN` | Token for Snyk dependency vulnerability scans |
| `AZURE_CLIENT_ID` | Client ID of the deployment Service Principal (OIDC) |
| `AZURE_TENANT_ID` | Azure Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID (`65bf2554-8090-4538-9c38-8a6e9c5f6f22`) |
| `ACR_LOGIN_SERVER` | Azure Container Registry login server (e.g., `acraeroinboxprod.azurecr.io`) |
| `ACR_NAME` | ACR registry name (e.g., `acraeroinboxprod`) |
| `MAIL_USERNAME` | SMTP sender username (Gmail account) |
| `MAIL_PASSWORD` | SMTP app password for Gmail notifications |
| `MAIL_TO` | Notification recipient email |
| `HELM_REPO_PAT` | Personal Access Token with write access to `aeroinbox-helm` repo |

---

## Step 3: Destroy Current Infrastructure

To completely clean up the current environment:

```bash
# Navigate to the environment directory
cd aeroinbox-terraform/environments/production

# Destroy the resources
terraform destroy -auto-approve
```

---

## Step 4: Provision Tomorrow's Infrastructure (Terraform Apply)

To re-create the infrastructure from scratch:

```bash
# 1. Initialize Terraform
terraform init

# 2. Validate configuration
terraform validate

# 3. Create a dry-run plan
terraform plan -out=tfplan

# 4. Apply the plan to create resources
terraform apply tfplan
```

### 5. Create the PostgreSQL Database (AUTOMATED)

The creation of the `aeroinbox` database is now fully automated and managed inside Terraform. No manual CLI commands are needed. However, you can verify that the database exists and is healthy by running:

```bash
az postgres flexible-server db show \
  --resource-group rg-aeroinbox-prod \
  --server-name pg-aeroinbox-prod \
  --database-name aeroinbox
```

*Note: Once complete, Terraform will print outputs like the Key Vault URI (`key_vault_uri`) and ACR Server (`acr_login_server`).*

### 6. Verify WAF Policy Detection Mode (CRITICAL)

To prevent the Google OAuth callback from being blocked by false-positive WAF rules (yielding 403 Forbidden errors), verify/ensure the Web Application Firewall policy is set to `Detection` mode:

```bash
az network application-gateway waf-policy policy-setting update \
  --policy-name waf-policy-aeroinbox-prod \
  --resource-group rg-aeroinbox-prod \
  --mode Detection
```

---

## Step 5: Key Vault Secrets Setup (CRITICAL - DO BEFORE CI/CD)

The application uses Azure Key Vault to load runtime credentials. 

### A. Automatically Created Secrets (No action needed)
The following secrets are **automatically generated and populated** by Terraform when running `apply`:
* `redis-access-key`
* `jwt-secret` (random 64-char key)
* `encryption-key` (random 32-char key)
* `postgres-host` (pointing to PostgreSQL FQDN)
* `postgres-db-name` (`aeroinbox`)
* `postgres-admin-username` (`id-aeroinbox-api-prod`)
* `application-insights-connection-string`

### B. Manually Created Secrets (MUST BE ADDED MANUALLY)
You must manually add the external API keys/values to the Key Vault. Get the `VAULT_NAME` from the Terraform output and run:

```bash
# 1. Set Google OAuth Client ID
az keyvault secret set --vault-name <VAULT_NAME> --name google-client-id --value "<YOUR_GOOGLE_CLIENT_ID>"

# 2. Set Google OAuth Client Secret
az keyvault secret set --vault-name <VAULT_NAME> --name google-client-secret --value "<YOUR_GOOGLE_CLIENT_SECRET>"

# 3. Set OpenAI API Key
az keyvault secret set --vault-name <VAULT_NAME> --name azure-openai-api-key --value "<YOUR_OPENAI_API_KEY>"

# 4. Set Service Bus connection string
az keyvault secret set --vault-name <VAULT_NAME> --name service-bus-connection-string --value "<YOUR_SERVICE_BUS_CONNECTION_STRING>"
```

---

## Step 6: Trigger CI/CD Build and Deploy Pipelines

1. Go to the `aeroinbox-app` GitHub repository.
2. Trigger the **Build Pipeline** workflow (`build.yml`) on the `main` branch. 
3. Select **"Push built images to ACR" = true**.
4. Once the Build workflow completes successfully, it will automatically trigger the **Deploy Pipeline** (`deploy.yml`).
5. The CD pipeline will push the new image tag updates to your `aeroinbox-helm` repository, initiating the ArgoCD rollout.

---

## Step 7: Jumpbox Deployment & ArgoCD Sync

1. In the Azure Portal, navigate to the `vm-jumpbox` Virtual Machine in resource group `rg-aeroinbox-prod`.
2. Connect via **Azure Bastion** using:
   * **Username**: `azureuser`
   * **Password**: `P@ssw0rd@123`
3. Run the following manual commands to initialize the deployment:

```bash
# 1. Verify AKS cluster connectivity
kubectl get nodes

# 2. Install ArgoCD via Server-Side Apply to avoid annotation size limits
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml --server-side

# 3. Deploy the AeroInbox application definition
kubectl apply -f ~/aeroinbox.yaml

# 4. Force ArgoCD to fetch files and reconcile immediately
kubectl annotate app aeroinbox -n argocd argocd.argoproj.io/refresh=normal

# 5. Verify the pods are starting up in the production namespace
kubectl get pods -n production
```

---

## Step 8: Access the ArgoCD Portal Locally

#### 1. Start Port Forwarding on the Jumpbox VM
Inside your **Azure Bastion terminal** (on the VM), run:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0
```
*(Leave this running).*

#### 2. Establish the Tunnel on Your Local PC
Open a **local terminal (PowerShell or CMD) on your laptop** (not in Bastion) and run:
```powershell
az network bastion tunnel --name bastion-aeroinbox-prod --resource-group rg-aeroinbox-prod --target-resource-id "/subscriptions/65bf2554-8090-4538-9c38-8a6e9c5f6f22/resourceGroups/rg-aeroinbox-prod/providers/Microsoft.Compute/virtualMachines/vm-jumpbox" --resource-port 8080 --port 8080
```
*(Leave this running).*

#### 3. Log In via Local Browser
1. Navigate to: **`https://localhost:8080`** in your browser.
2. Retrieve the initial admin password on the VM (in a second Bastion tab):
   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
   ```
3. Log in with:
   * **Username**: `admin`
   * **Password**: *[Output of the command above]*

---

## Step 9: Cloudflare DNS Mapping Update

After the infrastructure is provisioned, the Application Gateway's public IP address might change. You must verify and update your Cloudflare DNS mapping:

1. Retrieve the current Application Gateway public IP from your local PC terminal:
   ```bash
   cd aeroinbox-terraform/environments/production
   terraform output appgw_public_ip
   ```
2. Log in to **Cloudflare**.
3. Update the DNS **A records** for the following domains to point to the retrieved IP address:
   * **`aeroinbox.qzz.io`**
   * **`api.aeroinbox.qzz.io`**

