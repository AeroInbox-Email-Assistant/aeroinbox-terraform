variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. dev, prod)"
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID"
}

variable "subnet_db_id" {
  type        = string
  description = "The resource ID of the delegated database subnet"
}

variable "vnet_id" {
  type        = string
  description = "The resource ID of the virtual network"
}

variable "api_principal_id" {
  type        = string
  description = "The principal ID of the API managed identity"
}

variable "api_principal_name" {
  type        = string
  description = "The principal name of the API managed identity"
}

variable "rule_engine_principal_id" {
  type        = string
  description = "The principal ID of the rule engine managed identity"
}

variable "rule_engine_principal_name" {
  type        = string
  description = "The principal name of the rule engine managed identity"
}

variable "meeting_principal_id" {
  type        = string
  description = "The principal ID of the meeting managed identity"
}

variable "meeting_principal_name" {
  type        = string
  description = "The principal name of the meeting managed identity"
}

variable "pg_sku_name" {
  type        = string
  description = "The SKU name for the PostgreSQL Flexible Server"
  default     = "B_Standard_B1ms"
}

variable "pg_storage_mb" {
  type        = number
  description = "The storage capacity in MB for the PostgreSQL Flexible Server"
  default     = 32768
}

variable "pg_version" {
  type        = string
  description = "The version of PostgreSQL to deploy"
  default     = "15"
}

variable "redis_sku_name" {
  type        = string
  description = "The SKU name for the Redis Cache"
  default     = "Standard"
}

variable "redis_family" {
  type        = string
  description = "The SKU family for the Redis Cache"
  default     = "C"
}

variable "redis_capacity" {
  type        = number
  description = "The SKU capacity for the Redis Cache"
  default     = 1
}

variable "redis_non_ssl_port_enabled" {
  type        = bool
  description = "Whether the non-SSL port is enabled for Redis"
  default     = false
}

variable "redis_minimum_tls_version" {
  type        = string
  description = "The minimum TLS version supported by the Redis Cache"
  default     = "1.2"
}

variable "redis_port" {
  type        = number
  description = "The port number to expose for Redis traffic"
  default     = 6380
}

variable "postgres_dns_zone_name" {
  type        = string
  description = "The private DNS zone name for PostgreSQL"
  default     = "aeroinbox.private.postgres.database.azure.com"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
}
