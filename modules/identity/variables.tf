variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. dev, prod)"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the managed identities"
}
