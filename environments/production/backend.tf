terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aeroinbox-terraform-state"
    storage_account_name = "staeroinboxtfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_oidc             = true
  }
}
