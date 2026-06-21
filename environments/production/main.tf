locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "aeroinbox-team"
  }
}

module "resource_group" {
  source   = "../../modules/resource-group"
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = local.tags
}

module "network" {
  source                    = "../../modules/network"
  resource_group_name       = module.resource_group.name
  resource_group_id         = module.resource_group.id
  location                  = module.resource_group.location
  project_name              = var.project_name
  environment               = var.environment
  vnet_address_space        = var.vnet_address_space
  subnet_aks_prefixes       = var.subnet_aks_prefixes
  subnet_appgw_prefixes     = var.subnet_appgw_prefixes
  subnet_db_prefixes        = var.subnet_db_prefixes
  subnet_endpoints_prefixes = var.subnet_endpoints_prefixes
  tags                      = local.tags

  depends_on = [module.resource_group]
}

module "identity" {
  source              = "../../modules/identity"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  environment         = var.environment
  tags                = local.tags

  depends_on = [module.resource_group]
}

module "keyvault" {
  source                   = "../../modules/keyvault"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  project_name             = var.project_name
  environment              = var.environment
  tenant_id                = var.tenant_id
  terraform_sp_object_id   = var.terraform_sp_object_id
  api_principal_id         = module.identity.api_identity_principal_id
  gmail_principal_id       = module.identity.gmail_identity_principal_id
  ai_principal_id          = module.identity.ai_identity_principal_id
  rule_engine_principal_id = module.identity.rule_engine_identity_principal_id
  meeting_principal_id     = module.identity.meeting_identity_principal_id
  tags                     = local.tags

  depends_on = [module.identity]
}

module "acr" {
  source              = "../../modules/acr"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  project_name        = var.project_name
  environment         = var.environment
  tags                = local.tags

  depends_on = [module.resource_group]
}

module "database" {
  source                     = "../../modules/database"
  resource_group_name        = module.resource_group.name
  location                   = module.resource_group.location
  project_name               = var.project_name
  environment                = var.environment
  tenant_id                  = var.tenant_id
  subnet_db_id               = module.network.subnet_db_id
  vnet_id                    = module.network.vnet_id
  api_principal_id           = module.identity.api_identity_principal_id
  api_principal_name         = "id-aeroinbox-api-${var.environment}"
  rule_engine_principal_id   = module.identity.rule_engine_identity_principal_id
  rule_engine_principal_name = "id-aeroinbox-rule-engine-${var.environment}"
  meeting_principal_id       = module.identity.meeting_identity_principal_id
  meeting_principal_name     = "id-aeroinbox-meeting-${var.environment}"
  postgres_dns_zone_name     = var.postgres_dns_zone_name
  tags                       = local.tags

  depends_on = [module.network, module.identity]
}

module "servicebus" {
  source               = "../../modules/servicebus"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  project_name         = var.project_name
  environment          = var.environment
  meeting_principal_id = module.identity.meeting_identity_principal_id
  tags                 = local.tags

  depends_on = [module.identity]
}

module "monitoring" {
  source              = "../../modules/monitoring"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  project_name        = var.project_name
  environment         = var.environment
  tags                = local.tags

  depends_on = [module.resource_group]
}

module "appgateway" {
  source              = "../../modules/appgateway"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  project_name        = var.project_name
  environment         = var.environment
  subnet_appgw_id     = module.network.subnet_appgw_id
  appgw_sku_name      = var.appgw_sku_name
  appgw_sku_tier      = var.appgw_sku_tier
  tags                = local.tags

  depends_on = [module.network]
}

module "aks" {
  source                     = "../../modules/aks"
  resource_group_name        = module.resource_group.name
  resource_group_id          = module.resource_group.id
  location                   = module.resource_group.location
  project_name               = var.project_name
  environment                = var.environment
  subnet_aks_id              = module.network.subnet_aks_id
  acr_id                     = module.acr.acr_id
  appgw_id                   = module.appgateway.appgw_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  system_node_vm_size        = var.system_node_vm_size
  system_node_count          = var.system_node_count
  user_node_vm_size          = var.user_node_vm_size
  user_node_min_count        = var.user_node_min_count
  user_node_max_count        = var.user_node_max_count
  api_identity_id            = module.identity.api_identity_id
  api_client_id              = module.identity.api_identity_client_id
  api_principal_id           = module.identity.api_identity_principal_id
  gmail_identity_id          = module.identity.gmail_identity_id
  gmail_client_id            = module.identity.gmail_identity_client_id
  gmail_principal_id         = module.identity.gmail_identity_principal_id
  ai_identity_id             = module.identity.ai_identity_id
  ai_client_id               = module.identity.ai_identity_client_id
  ai_principal_id            = module.identity.ai_identity_principal_id
  rule_engine_identity_id    = module.identity.rule_engine_identity_id
  rule_engine_client_id      = module.identity.rule_engine_identity_client_id
  rule_engine_principal_id   = module.identity.rule_engine_identity_principal_id
  meeting_identity_id        = module.identity.meeting_identity_id
  meeting_client_id          = module.identity.meeting_identity_client_id
  meeting_principal_id       = module.identity.meeting_identity_principal_id
  tags                       = local.tags

  depends_on = [
    module.resource_group,
    module.network,
    module.identity,
    module.keyvault,
    module.acr,
    module.database,
    module.servicebus,
    module.monitoring,
    module.appgateway
  ]
}

module "private_endpoints" {
  source                  = "../../modules/private-endpoints"
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  vnet_id                 = module.network.vnet_id
  subnet_endpoints_id     = module.network.subnet_endpoints_id
  key_vault_id            = module.keyvault.key_vault_id
  acr_id                  = module.acr.acr_id
  servicebus_namespace_id = module.servicebus.servicebus_namespace_id
  redis_id                = module.database.redis_id
  tags                    = local.tags

  depends_on = [
    module.network,
    module.keyvault,
    module.acr,
    module.servicebus,
    module.database
  ]
}

# Role Assignments
resource "azurerm_role_assignment" "aks_gw_contributor" {
  scope                = module.appgateway.appgw_id
  role_definition_name = "Contributor"
  principal_id         = module.aks.aks_identity_principal_id
}

resource "azurerm_role_assignment" "aks_rg_reader" {
  scope                = module.resource_group.id
  role_definition_name = "Reader"
  principal_id         = module.aks.aks_identity_principal_id
}

resource "azurerm_role_assignment" "kubelet_acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.aks_kubelet_identity_object_id
}

# Random passwords for secrets
resource "random_password" "jwt_secret" {
  length  = 64
  special = true
}

resource "random_password" "encryption_key" {
  length  = 32
  special = false
}

# Key Vault Secrets
resource "azurerm_key_vault_secret" "redis_key" {
  name         = "redis-access-key"
  value        = module.database.redis_primary_access_key
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "jwt-secret"
  value        = random_password.jwt_secret.result
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}

resource "azurerm_key_vault_secret" "encryption_key" {
  name         = "encryption-key"
  value        = random_password.encryption_key.result
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}

resource "azurerm_key_vault_secret" "postgres_host" {
  name         = "postgres-host"
  value        = module.database.postgres_fqdn
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}

resource "azurerm_key_vault_secret" "postgres_db_name" {
  name         = "postgres-db-name"
  value        = "aeroinbox"
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}

resource "azurerm_key_vault_secret" "postgres_admin_username" {
  name         = "postgres-admin-username"
  value        = "id-aeroinbox-api-${var.environment}"
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}

resource "azurerm_key_vault_secret" "app_insights_connection_string" {
  name         = "application-insights-connection-string"
  value        = module.monitoring.app_insights_connection_string
  key_vault_id = module.keyvault.key_vault_id

  depends_on = [module.private_endpoints]
}
