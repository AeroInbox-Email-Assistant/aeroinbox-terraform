resource "random_id" "kv_name" {
  byte_length = 3
}

module "keyvault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.9.1"

  name                           = "kv-${var.project_name}-${var.environment}-${random_id.kv_name.hex}"
  resource_group_name            = var.resource_group_name
  location                       = var.location
  tenant_id                      = var.tenant_id
  sku_name                       = "standard"
  legacy_access_policies_enabled = false
  purge_protection_enabled       = true
  public_network_access_enabled  = false
  tags                           = var.tags
}

resource "azurerm_role_assignment" "tf_sp_secrets_officer" {
  scope                = module.keyvault.resource_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.terraform_sp_object_id
}

resource "azurerm_role_assignment" "api_secrets_user" {
  scope                = module.keyvault.resource_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.api_principal_id
}

resource "azurerm_role_assignment" "gmail_secrets_user" {
  scope                = module.keyvault.resource_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.gmail_principal_id
}

resource "azurerm_role_assignment" "ai_secrets_user" {
  scope                = module.keyvault.resource_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.ai_principal_id
}

resource "azurerm_role_assignment" "rule_engine_secrets_user" {
  scope                = module.keyvault.resource_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.rule_engine_principal_id
}

resource "azurerm_role_assignment" "meeting_secrets_user" {
  scope                = module.keyvault.resource_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.meeting_principal_id
}
