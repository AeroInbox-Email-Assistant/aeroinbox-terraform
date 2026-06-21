resource "azurerm_private_dns_zone" "postgres" {
  name                = var.postgres_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "link-postgres-${var.project_name}-${var.environment}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

module "postgresql" {
  source  = "Azure/avm-res-dbforpostgresql-flexibleserver/azurerm"
  version = "0.2.2"

  name                = "pg-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.pg_sku_name
  storage_mb          = var.pg_storage_mb
  server_version      = var.pg_version
  delegated_subnet_id = var.subnet_db_id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  # Disable default AllowAllFireWallRule and ensure public network access is disabled
  firewall_rules                = {}
  public_network_access_enabled = false
  high_availability             = null

  authentication = {
    active_directory_auth_enabled = true
    password_auth_enabled         = false
    tenant_id                     = var.tenant_id
  }

  tags = var.tags

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.postgres
  ]
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "api" {
  server_name         = module.postgresql.name
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.api_principal_id
  principal_name      = var.api_principal_name
  principal_type      = "ServicePrincipal"
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "rule_engine" {
  server_name         = module.postgresql.name
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.rule_engine_principal_id
  principal_name      = var.rule_engine_principal_name
  principal_type      = "ServicePrincipal"
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "meeting" {
  server_name         = module.postgresql.name
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.meeting_principal_id
  principal_name      = var.meeting_principal_name
  principal_type      = "ServicePrincipal"
}

resource "azurerm_managed_redis" "redis" {
  name                = "redis-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.redis_sku_name == "Standard" || var.redis_sku_name == "Basic" ? "Balanced_B0" : var.redis_sku_name
  tags                = var.tags

  default_database {
    access_keys_authentication_enabled = true
  }
}
