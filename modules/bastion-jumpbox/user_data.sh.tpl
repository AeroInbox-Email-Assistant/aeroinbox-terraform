#!/bin/bash
set -e

LOG_FILE="/home/azureuser/bootstrap.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "============================================="
echo "Starting Automated AeroInbox Bootstrapping..."
echo "Timestamp: $(date)"
echo "============================================="

# 1. Setup kubeconfig
echo "Configuring kubeconfig..."
mkdir -p /home/azureuser/.kube
cat << 'EOF' > /home/azureuser/.kube/config
${kube_config}
EOF
chmod 600 /home/azureuser/.kube/config
chown -R azureuser:azureuser /home/azureuser/.kube

# Copy kubeconfig to root for installation scripts
mkdir -p /root/.kube
cp /home/azureuser/.kube/config /root/.kube/config
chmod 600 /root/.kube/config

# 2. Setup aeroinbox.yaml
echo "Configuring aeroinbox.yaml..."
cat << 'EOF' > /home/azureuser/aeroinbox.yaml
${aeroinbox_yaml}
EOF
chmod 644 /home/azureuser/aeroinbox.yaml
chown azureuser:azureuser /home/azureuser/aeroinbox.yaml

# 3. Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

# 4. Install helm
echo "Installing helm..."
curl -LO "https://get.helm.sh/helm-v3.15.1-linux-amd64.tar.gz"
tar -zxvf helm-v3.15.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/
rm -rf linux-amd64 helm-v3.15.1-linux-amd64.tar.gz

# 5. Wait for Private AKS API connection
echo "Waiting for AKS private API server link to become reachable..."
success=false
for i in {1..30}; do
  if kubectl get nodes >/dev/null 2>&1; then
    echo "AKS connection established successfully!"
    success=true
    break
  fi
  echo "AKS API not yet reachable, retrying in 10 seconds (attempt $i/30)..."
  sleep 10
done

if [ "$success" = "false" ]; then
  echo "Timeout waiting for AKS API server connection."
  exit 1
fi

# 6. Install ArgoCD
echo "Installing ArgoCD..."
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 7. Apply AeroInbox application
echo "Deploying AeroInbox application via ArgoCD..."
kubectl apply -f /home/azureuser/aeroinbox.yaml

echo "============================================="
echo "AeroInbox Bootstrapping completed successfully!"
echo "Timestamp: $(date)"
echo "============================================="
chown azureuser:azureuser $LOG_FILE
