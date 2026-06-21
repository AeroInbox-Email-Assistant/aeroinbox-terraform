locals {
  backend_address_pool_name      = "aks-backend-pool"
  frontend_port_name_80          = "port-80"
  frontend_port_name_443         = "port-443"
  frontend_ip_configuration_name = "agw-frontend-ip"
  http_setting_name              = "aks-http-settings"
  listener_name                  = "aks-http-listener"
  request_routing_rule_name      = "aks-routing-rule"
  probe_name                     = "aks-health-probe"
}

resource "azurerm_web_application_firewall_policy" "waf" {
  count               = startswith(var.appgw_sku_name, "WAF") ? 1 : 0
  name                = "waf-policy-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  policy_settings {
    enabled = true
    mode    = "Prevention"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

resource "azurerm_public_ip" "appgw" {
  name                = "pip-appgw-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = ["1", "2", "3"]
  tags                = var.tags
}

resource "azurerm_application_gateway" "appgw" {
  name                = "agw-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  sku {
    name = var.appgw_sku_name
    tier = var.appgw_sku_tier
  }

  firewall_policy_id = startswith(var.appgw_sku_name, "WAF") ? azurerm_web_application_firewall_policy.waf[0].id : null

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 3
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.subnet_appgw_id
  }

  frontend_port {
    name = local.frontend_port_name_80
    port = 80
  }

  frontend_port {
    name = local.frontend_port_name_443
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                                = local.http_setting_name
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 30
    probe_name                          = local.probe_name
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name_80
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 100
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  probe {
    name                                      = local.probe_name
    protocol                                  = "Http"
    path                                      = "/healthz"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }


}
