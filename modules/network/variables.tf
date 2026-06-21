variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "resource_group_id" {
  type        = string
  description = "The resource ID of the resource group (used as parent_id in AVM)"
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

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network"
}

variable "subnet_aks_prefixes" {
  type        = list(string)
  description = "The address prefixes for the AKS subnet"
}

variable "subnet_appgw_prefixes" {
  type        = list(string)
  description = "The address prefixes for the App Gateway subnet"
}

variable "subnet_db_prefixes" {
  type        = list(string)
  description = "The address prefixes for the database subnet"
}

variable "subnet_endpoints_prefixes" {
  type        = list(string)
  description = "The address prefixes for the private endpoints subnet"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the virtual network"
}
