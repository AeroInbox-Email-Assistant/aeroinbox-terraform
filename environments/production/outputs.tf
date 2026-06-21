output "resource_group_name" {
  value       = module.resource_group.name
  description = "The name of the resource group"
}

output "aks_cluster_name" {
  value       = module.aks.aks_cluster_name
  description = "The name of the AKS cluster"
}

output "acr_login_server" {
  value       = module.acr.acr_login_server
  description = "The login server URL of the ACR registry"
}

output "key_vault_uri" {
  value       = module.keyvault.key_vault_uri
  description = "The URI of the Key Vault"
}

output "postgres_fqdn" {
  value       = module.database.postgres_fqdn
  description = "The FQDN of the PostgreSQL Flexible Server"
}

output "appgw_public_ip" {
  value       = module.appgateway.appgw_public_ip_address
  description = "The public IP address of the Application Gateway"
}

output "aks_oidc_issuer_url" {
  value       = module.aks.aks_oidc_issuer_url
  description = "The OIDC issuer URL of the AKS cluster"
}

output "app_insights_connection_string" {
  value       = module.monitoring.app_insights_connection_string
  description = "The connection string for Application Insights"
  sensitive   = true
}

output "api_identity_client_id" {
  value       = module.identity.api_identity_client_id
  description = "The Client ID of the API managed identity"
}

output "gmail_identity_client_id" {
  value       = module.identity.gmail_identity_client_id
  description = "The Client ID of the Gmail managed identity"
}

output "ai_identity_client_id" {
  value       = module.identity.ai_identity_client_id
  description = "The Client ID of the AI managed identity"
}

output "rule_engine_identity_client_id" {
  value       = module.identity.rule_engine_identity_client_id
  description = "The Client ID of the rule engine managed identity"
}

output "meeting_identity_client_id" {
  value       = module.identity.meeting_identity_client_id
  description = "The Client ID of the meeting managed identity"
}

output "jwt_secret_name" {
  value       = "jwt-secret"
  description = "Key Vault secret name for JWT"
}

output "encryption_key_name" {
  value       = "encryption-key"
  description = "Key Vault secret name for encryption key"
}
