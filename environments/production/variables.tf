variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "The Azure tenant ID"
  sensitive   = true
}

variable "client_id" {
  type        = string
  description = "The client ID of the service principal executing Terraform"
  sensitive   = true
}

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of Terraform Service Principal"
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "The name of the project"
  default     = "aeroinbox"
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g. dev, prod)"
  default     = "prod"
}

variable "location" {
  type        = string
  description = "The Azure region to deploy resources"
  default     = "centralindia"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The VNet IP address range"
  default     = ["10.0.0.0/16"]
}

variable "subnet_aks_prefixes" {
  type        = list(string)
  description = "The IP address range for the AKS subnet"
  default     = ["10.0.0.0/20"]
}

variable "subnet_appgw_prefixes" {
  type        = list(string)
  description = "The IP address range for the App Gateway subnet"
  default     = ["10.0.16.0/24"]
}

variable "subnet_db_prefixes" {
  type        = list(string)
  description = "The IP address range for the DB subnet"
  default     = ["10.0.17.0/24"]
}

variable "subnet_endpoints_prefixes" {
  type        = list(string)
  description = "The IP address range for the Private Endpoints subnet"
  default     = ["10.0.18.0/24"]
}

variable "system_node_vm_size" {
  type        = string
  description = "The VM size for system node pool"
  default     = "Standard_D2s_v3"
}

variable "system_node_count" {
  type        = number
  description = "The number of nodes in the system node pool"
  default     = 2
}

variable "user_node_vm_size" {
  type        = string
  description = "The VM size for user node pool"
  default     = "Standard_D2s_v3"
}

variable "user_node_min_count" {
  type        = number
  description = "The minimum number of nodes in the user node pool"
  default     = 2
}

variable "user_node_max_count" {
  type        = number
  description = "The maximum number of nodes in the user node pool"
  default     = 5
}

variable "appgw_sku_name" {
  type        = string
  description = "The SKU name of the Application Gateway"
  default     = "WAF_v2"
}

variable "appgw_sku_tier" {
  type        = string
  description = "The SKU tier of the Application Gateway"
  default     = "WAF_v2"
}

variable "postgres_dns_zone_name" {
  type        = string
  description = "The private DNS zone name for PostgreSQL"
  default     = "privatelink.postgres.database.azure.com"
}

variable "user_node_pool_enabled" {
  type        = bool
  description = "Whether to create a separate user node pool"
  default     = false
}
