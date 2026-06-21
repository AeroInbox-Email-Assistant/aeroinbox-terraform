output "key_vault_id" {
  value       = module.keyvault.resource_id
  description = "The resource ID of the key vault"
}

output "key_vault_uri" {
  value       = module.keyvault.uri
  description = "The URI of the key vault"
}

output "key_vault_name" {
  value       = "kv-${var.project_name}-${var.environment}"
  description = "The name of the key vault"
}
