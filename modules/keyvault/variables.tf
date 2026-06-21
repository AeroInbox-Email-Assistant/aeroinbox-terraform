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

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of Terraform Service Principal for Key Vault Secrets Officer role"
}

variable "api_principal_id" {
  type        = string
  description = "The principal ID of the API managed identity"
}

variable "gmail_principal_id" {
  type        = string
  description = "The principal ID of the Gmail managed identity"
}

variable "ai_principal_id" {
  type        = string
  description = "The principal ID of the AI managed identity"
}

variable "rule_engine_principal_id" {
  type        = string
  description = "The principal ID of the rule engine managed identity"
}

variable "meeting_principal_id" {
  type        = string
  description = "The principal ID of the meeting managed identity"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the key vault"
}
