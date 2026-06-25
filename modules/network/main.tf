module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.17.1"

  name          = "vnet-${var.project_name}-${var.environment}"
  location      = var.location
  parent_id     = var.resource_group_id
  address_space = var.vnet_address_space
  tags          = var.tags

  subnets = {
    snet-aks = {
      name             = "snet-aks"
      address_prefixes = var.subnet_aks_prefixes
    }
    snet-appgw = {
      name             = "snet-appgw"
      address_prefixes = var.subnet_appgw_prefixes
    }
    snet-db = {
      name             = "snet-db"
      address_prefixes = var.subnet_db_prefixes
      delegations = [
        {
          name = "psql-delegation"
          service_delegation = {
            name    = "Microsoft.DBforPostgreSQL/flexibleServers"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }
      ]
    }
    snet-endpoints = {
      name             = "snet-endpoints"
      address_prefixes = var.subnet_endpoints_prefixes
    }
    AzureBastionSubnet = {
      name             = "AzureBastionSubnet"
      address_prefixes = var.subnet_bastion_prefixes
    }
    snet-jumpbox = {
      name             = "snet-jumpbox"
      address_prefixes = var.subnet_jumpbox_prefixes
    }
  }
}
