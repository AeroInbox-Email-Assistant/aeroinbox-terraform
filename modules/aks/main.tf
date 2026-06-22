module "aks" {
  source  = "Azure/avm-res-containerservice-managedcluster/azurerm"
  version = "0.6.1"

  name               = "aks-${var.project_name}-${var.environment}"
  location           = var.location
  parent_id          = var.resource_group_id
  kubernetes_version = "1.33"
  dns_prefix         = "aks-${var.project_name}-${var.environment}"
  tags               = var.tags

  network_profile = {
    network_plugin = "azure"
    service_cidr   = "10.240.0.0/16"
    dns_service_ip = "10.240.0.10"
  }

  default_agent_pool = {
    name            = "agentpool"
    vm_size         = var.system_node_vm_size
    count_of        = var.system_node_count
    vnet_subnet_id  = var.subnet_aks_id
    os_disk_size_gb = 30
  }

  agent_pools = var.user_node_pool_enabled ? {
    userpool = {
      name                = "userpool"
      vm_size             = var.user_node_vm_size
      min_count           = var.user_node_min_count
      max_count           = var.user_node_max_count
      enable_auto_scaling = true
      mode                = "User"
      vnet_subnet_id      = var.subnet_aks_id
    }
  } : {}

  # Enabled features
  oidc_issuer_profile = {
    enabled = true
  }

  security_profile = {
    workload_identity = {
      enabled = true
    }
  }

  addon_profile_key_vault_secrets_provider = {
    enabled = true
  }

  workload_auto_scaler_profile = {
    keda = {
      enabled = true
    }
  }

  addon_profile_ingress_application_gateway = {
    enabled = true
    config = {
      application_gateway_id = var.appgw_id
    }
  }

  addon_profile_oms_agent = {
    enabled = true
    config = {
      log_analytics_workspace_resource_id = var.log_analytics_workspace_id
    }
  }

  # Disabled features
  ingress_profile = {
    web_app_routing = {
      enabled = false
    }
  }
}

resource "azurerm_federated_identity_credential" "api" {
  name                = "api-federation"
  resource_group_name = var.resource_group_name
  parent_id           = var.api_identity_id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_profile_issuer_url
  subject             = "system:serviceaccount:aeroinbox:api-sa"
}

resource "azurerm_federated_identity_credential" "gmail" {
  name                = "gmail-federation"
  resource_group_name = var.resource_group_name
  parent_id           = var.gmail_identity_id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_profile_issuer_url
  subject             = "system:serviceaccount:aeroinbox:gmail-sa"
}

resource "azurerm_federated_identity_credential" "ai" {
  name                = "ai-federation"
  resource_group_name = var.resource_group_name
  parent_id           = var.ai_identity_id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_profile_issuer_url
  subject             = "system:serviceaccount:aeroinbox:ai-sa"
}

resource "azurerm_federated_identity_credential" "rule_engine" {
  name                = "rule-engine-federation"
  resource_group_name = var.resource_group_name
  parent_id           = var.rule_engine_identity_id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_profile_issuer_url
  subject             = "system:serviceaccount:aeroinbox:rule-engine-sa"
}

resource "azurerm_federated_identity_credential" "meeting" {
  name                = "meeting-federation"
  resource_group_name = var.resource_group_name
  parent_id           = var.meeting_identity_id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_profile_issuer_url
  subject             = "system:serviceaccount:aeroinbox:meeting-sa"
}
