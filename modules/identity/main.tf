module "identity_api" {
  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version             = "0.5.0"
  name                = "id-aeroinbox-api-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "identity_gmail" {
  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version             = "0.5.0"
  name                = "id-aeroinbox-gmail-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "identity_ai" {
  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version             = "0.5.0"
  name                = "id-aeroinbox-ai-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "identity_rule_engine" {
  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version             = "0.5.0"
  name                = "id-aeroinbox-rule-engine-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "identity_meeting" {
  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  version             = "0.5.0"
  name                = "id-aeroinbox-meeting-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}
