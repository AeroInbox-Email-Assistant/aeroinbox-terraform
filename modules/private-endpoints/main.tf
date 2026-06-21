resource "azurerm_private_dns_zone" "vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "sb" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vault" {
  name                  = "link-dns-vault"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.vault.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr" {
  name                  = "link-dns-acr"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "sb" {
  name                  = "link-dns-sb"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sb.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis" {
  name                  = "link-dns-redis"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.redis.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

resource "azurerm_private_endpoint" "vault" {
  name                = "pe-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_endpoints_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-keyvault"
    private_connection_resource_id = var.key_vault_id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "dns-group-vault"
    private_dns_zone_ids = [azurerm_private_dns_zone.vault.id]
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.vault
  ]
}

resource "azurerm_private_endpoint" "acr" {
  name                = "pe-acr"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_endpoints_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-acr"
    private_connection_resource_id = var.acr_id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = "dns-group-acr"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.acr
  ]
}

resource "azurerm_private_endpoint" "sb" {
  name                = "pe-servicebus"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_endpoints_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-servicebus"
    private_connection_resource_id = var.servicebus_namespace_id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  private_dns_zone_group {
    name                 = "dns-group-sb"
    private_dns_zone_ids = [azurerm_private_dns_zone.sb.id]
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.sb
  ]
}

resource "azurerm_private_endpoint" "redis" {
  name                = "pe-redis"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_endpoints_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-redis"
    private_connection_resource_id = var.redis_id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  private_dns_zone_group {
    name                 = "dns-group-redis"
    private_dns_zone_ids = [azurerm_private_dns_zone.redis.id]
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.redis
  ]
}
