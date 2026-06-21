variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "vnet_id" {
  type        = string
  description = "The resource ID of the virtual network"
}

variable "subnet_endpoints_id" {
  type        = string
  description = "The resource ID of the private endpoints subnet"
}

variable "key_vault_id" {
  type        = string
  description = "The resource ID of the Key Vault"
}

variable "acr_id" {
  type        = string
  description = "The resource ID of the Azure Container Registry"
}

variable "servicebus_namespace_id" {
  type        = string
  description = "The resource ID of the Service Bus Namespace"
}

variable "redis_id" {
  type        = string
  description = "The resource ID of the Redis Cache"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the Private Endpoint resources"
}
