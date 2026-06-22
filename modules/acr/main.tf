# Public network access is explicitly enabled to allow GitHub Actions
# CI/CD runners to build and push container images to the registry.
module "acr" {
  source  = "Azure/avm-res-containerregistry-registry/azurerm"
  version = "0.5.1"

  name                          = lower("acr${replace(var.project_name, "-", "")}${replace(var.environment, "-", "")}")
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Premium"
  admin_enabled                 = true
  public_network_access_enabled = true
  zone_redundancy_enabled       = false
  tags                          = var.tags
}
