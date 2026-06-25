output "vnet_id" {
  value       = module.vnet.resource_id
  description = "The resource ID of the virtual network"
}

output "vnet_name" {
  value       = module.vnet.name
  description = "The name of the virtual network"
}

output "subnet_aks_id" {
  value       = module.vnet.subnets["snet-aks"].resource_id
  description = "The resource ID of the AKS subnet"
}

output "subnet_appgw_id" {
  value       = module.vnet.subnets["snet-appgw"].resource_id
  description = "The resource ID of the App Gateway subnet"
}

output "subnet_db_id" {
  value       = module.vnet.subnets["snet-db"].resource_id
  description = "The resource ID of the database subnet"
}

output "subnet_endpoints_id" {
  value       = module.vnet.subnets["snet-endpoints"].resource_id
  description = "The resource ID of the private endpoints subnet"
}

output "subnet_bastion_id" {
  value       = module.vnet.subnets["AzureBastionSubnet"].resource_id
  description = "The resource ID of the Azure Bastion subnet"
}

output "subnet_jumpbox_id" {
  value       = module.vnet.subnets["snet-jumpbox"].resource_id
  description = "The resource ID of the private Jumpbox subnet"
}
