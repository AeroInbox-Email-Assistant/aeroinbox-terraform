output "postgres_server_id" {
  value       = module.postgresql.resource_id
  description = "The resource ID of the PostgreSQL Flexible Server"
}

output "postgres_fqdn" {
  value       = module.postgresql.fqdn
  description = "The FQDN of the PostgreSQL Flexible Server"
}

output "postgres_server_name" {
  value       = module.postgresql.name
  description = "The name of the PostgreSQL Flexible Server"
}

output "redis_id" {
  value       = azurerm_managed_redis.redis.id
  description = "The resource ID of the Redis Cache"
}

output "redis_hostname" {
  value       = azurerm_managed_redis.redis.hostname
  description = "The hostname of the Redis Cache"
  sensitive   = true
}

output "redis_primary_access_key" {
  value       = one(azurerm_managed_redis.redis.default_database[*].primary_access_key)
  description = "The primary access key of the Redis Cache"
  sensitive   = true
}

output "redis_port" {
  value       = var.redis_port
  description = "The port number of the Redis Cache"
}
