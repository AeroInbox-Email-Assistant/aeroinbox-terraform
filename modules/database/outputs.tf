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
  value       = azurerm_redis_cache.redis.id
  description = "The resource ID of the Redis Cache"
}

output "redis_hostname" {
  value       = azurerm_redis_cache.redis.hostname
  description = "The hostname of the Redis Cache"
  sensitive   = true
}

output "redis_primary_access_key" {
  value       = azurerm_redis_cache.redis.primary_access_key
  description = "The primary access key of the Redis Cache"
  sensitive   = true
}

output "redis_port" {
  value       = var.redis_port
  description = "The port number of the Redis Cache"
}
