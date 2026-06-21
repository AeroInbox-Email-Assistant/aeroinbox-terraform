output "pe_keyvault_ip" {
  value       = azurerm_private_endpoint.vault.private_service_connection[0].private_ip_address
  description = "The private IP address of the Key Vault private endpoint"
}

output "pe_acr_ip" {
  value       = azurerm_private_endpoint.acr.private_service_connection[0].private_ip_address
  description = "The private IP address of the ACR private endpoint"
}

output "pe_servicebus_ip" {
  value       = azurerm_private_endpoint.sb.private_service_connection[0].private_ip_address
  description = "The private IP address of the Service Bus private endpoint"
}

output "pe_redis_ip" {
  value       = azurerm_private_endpoint.redis.private_service_connection[0].private_ip_address
  description = "The private IP address of the Redis private endpoint"
}
