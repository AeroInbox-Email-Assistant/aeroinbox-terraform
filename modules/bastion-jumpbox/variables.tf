variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "subnet_bastion_id" {
  type        = string
  description = "The resource ID of the Azure Bastion subnet (AzureBastionSubnet)"
}

variable "subnet_jumpbox_id" {
  type        = string
  description = "The resource ID of the private Jumpbox subnet"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. dev, prod)"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
}
