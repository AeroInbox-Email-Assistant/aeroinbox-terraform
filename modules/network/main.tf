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

resource "azurerm_public_ip" "natgw" {
  name                = "pip-natgw-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = "natgw-${var.project_name}-${var.environment}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "natgw" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw.id
}

resource "azurerm_subnet_nat_gateway_association" "jumpbox" {
  subnet_id      = module.vnet.subnets["snet-jumpbox"].resource_id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}

resource "azurerm_subnet_nat_gateway_association" "aks" {
  subnet_id      = module.vnet.subnets["snet-aks"].resource_id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}

