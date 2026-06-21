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

variable "subnet_aks_id" {
  type        = string
  description = "The resource ID of the subnet for AKS"
}

variable "acr_id" {
  type        = string
  description = "The resource ID of the Azure Container Registry"
}

variable "appgw_id" {
  type        = string
  description = "The resource ID of the Application Gateway"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The resource ID of the Log Analytics Workspace for diagnostics and monitoring"
}

variable "system_node_vm_size" {
  type        = string
  description = "The VM size for the AKS system node pool"
}

variable "system_node_count" {
  type        = number
  description = "The number of nodes in the AKS system node pool"
}

variable "user_node_vm_size" {
  type        = string
  description = "The VM size for the AKS user node pool"
}

variable "user_node_min_count" {
  type        = number
  description = "The minimum number of nodes in the AKS user node pool"
}

variable "user_node_max_count" {
  type        = number
  description = "The maximum number of nodes in the AKS user node pool"
}

variable "api_identity_id" {
  type        = string
  description = "The resource ID of the API managed identity"
}

variable "api_client_id" {
  type        = string
  description = "The client ID of the API managed identity"
}

variable "api_principal_id" {
  type        = string
  description = "The principal ID of the API managed identity"
}

variable "gmail_identity_id" {
  type        = string
  description = "The resource ID of the Gmail managed identity"
}

variable "gmail_client_id" {
  type        = string
  description = "The client ID of the Gmail managed identity"
}

variable "gmail_principal_id" {
  type        = string
  description = "The principal ID of the Gmail managed identity"
}

variable "ai_identity_id" {
  type        = string
  description = "The resource ID of the AI managed identity"
}

variable "ai_client_id" {
  type        = string
  description = "The client ID of the AI managed identity"
}

variable "ai_principal_id" {
  type        = string
  description = "The principal ID of the AI managed identity"
}

variable "rule_engine_identity_id" {
  type        = string
  description = "The resource ID of the rule engine managed identity"
}

variable "rule_engine_client_id" {
  type        = string
  description = "The client ID of the rule engine managed identity"
}

variable "rule_engine_principal_id" {
  type        = string
  description = "The principal ID of the rule engine managed identity"
}

variable "meeting_identity_id" {
  type        = string
  description = "The resource ID of the meeting managed identity"
}

variable "meeting_client_id" {
  type        = string
  description = "The client ID of the meeting managed identity"
}

variable "meeting_principal_id" {
  type        = string
  description = "The principal ID of the meeting managed identity"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the AKS resources"
}
