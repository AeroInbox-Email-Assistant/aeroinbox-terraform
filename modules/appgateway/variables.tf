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

variable "subnet_appgw_id" {
  type        = string
  description = "The resource ID of the subnet for the Application Gateway"
}

variable "appgw_sku_name" {
  type        = string
  description = "The SKU name for the Application Gateway (e.g., Standard_v2, WAF_v2)"
}

variable "appgw_sku_tier" {
  type        = string
  description = "The SKU tier for the Application Gateway (e.g., Standard_v2, WAF_v2)"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the App Gateway resources"
}
