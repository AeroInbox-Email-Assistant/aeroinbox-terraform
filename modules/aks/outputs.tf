output "aks_cluster_id" {
  value       = module.aks.resource_id
  description = "The resource ID of the AKS cluster"
}

output "aks_cluster_name" {
  value       = module.aks.name
  description = "The name of the AKS cluster"
}

output "aks_oidc_issuer_url" {
  value       = module.aks.oidc_issuer_profile_issuer_url
  description = "The OIDC issuer profile URL of the AKS cluster"
}

output "aks_kubelet_identity_object_id" {
  value       = try(module.aks.kubelet_identity.objectId, "")
  description = "The Object ID of the AKS Kubelet identity"
}

output "aks_kubelet_identity_client_id" {
  value       = try(module.aks.kubelet_identity.clientId, "")
  description = "The Client ID of the AKS Kubelet identity"
}

output "aks_identity_principal_id" {
  value       = module.aks.identity_principal_id
  description = "The principal ID of the AKS cluster identity"
}

output "kube_config" {
  value       = module.aks.kube_admin_config
  description = "The raw admin kubeconfig YAML for the AKS cluster"
  sensitive   = true
}

output "aks_control_plane_fqdn" {
  value       = module.aks.fqdn
  description = "The control plane FQDN of the AKS cluster"
}

output "aks_control_plane_private_fqdn" {
  value       = module.aks.private_fqdn
  description = "The control plane private FQDN of the AKS cluster (if private)"
}

output "aks_node_resource_group" {
  value       = module.aks.node_resource_group_name
  description = "The auto-created node resource group for AKS agent nodes"
}
