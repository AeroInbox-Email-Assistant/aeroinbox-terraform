import {
  to = module.network.module.vnet.azapi_resource.vnet
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/virtualNetworks/vnet-${var.project_name}-${var.environment}"
}

import {
  to = module.network.module.vnet.module.subnet["snet-aks"].azapi_resource.subnet[0]
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/virtualNetworks/vnet-${var.project_name}-${var.environment}/subnets/snet-aks"
}

import {
  to = module.network.module.vnet.module.subnet["snet-appgw"].azapi_resource.subnet[0]
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/virtualNetworks/vnet-${var.project_name}-${var.environment}/subnets/snet-appgw"
}

import {
  to = module.network.module.vnet.module.subnet["snet-db"].azapi_resource.subnet[0]
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/virtualNetworks/vnet-${var.project_name}-${var.environment}/subnets/snet-db"
}

import {
  to = module.network.module.vnet.module.subnet["snet-endpoints"].azapi_resource.subnet[0]
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/virtualNetworks/vnet-${var.project_name}-${var.environment}/subnets/snet-endpoints"
}

import {
  to = module.identity.module.identity_api.azurerm_user_assigned_identity.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-${var.project_name}-api-${var.environment}"
}

import {
  to = module.identity.module.identity_gmail.azurerm_user_assigned_identity.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-${var.project_name}-gmail-${var.environment}"
}

import {
  to = module.identity.module.identity_ai.azurerm_user_assigned_identity.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-${var.project_name}-ai-${var.environment}"
}

import {
  to = module.identity.module.identity_rule_engine.azurerm_user_assigned_identity.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-${var.project_name}-rule-engine-${var.environment}"
}

import {
  to = module.identity.module.identity_meeting.azurerm_user_assigned_identity.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-${var.project_name}-meeting-${var.environment}"
}

import {
  to = module.acr.module.acr.azurerm_container_registry.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ContainerRegistry/registries/acraeroinboxprod"
}

import {
  to = module.monitoring.azurerm_log_analytics_workspace.log
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.OperationalInsights/workspaces/log-${var.project_name}-${var.environment}"
}

import {
  to = module.monitoring.azurerm_application_insights.appi
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Insights/components/appi-${var.project_name}-${var.environment}"
}

import {
  to = module.appgateway.azurerm_public_ip.appgw
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/publicIPAddresses/pip-appgw-${var.project_name}-${var.environment}"
}

import {
  to = module.appgateway.azurerm_web_application_firewall_policy.waf[0]
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/waf-policy-${var.project_name}-${var.environment}"
}

import {
  to = module.appgateway.azurerm_application_gateway.appgw
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/applicationGateways/agw-${var.project_name}-${var.environment}"
}

import {
  to = module.servicebus.module.servicebus_namespace.azurerm_servicebus_namespace.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ServiceBus/namespaces/sb-${var.project_name}-${var.environment}"
}

import {
  to = module.servicebus.azurerm_servicebus_queue.meeting_reminders
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.ServiceBus/namespaces/sb-${var.project_name}-${var.environment}/queues/meeting-reminders"
}

import {
  to = module.database.azurerm_redis_cache.redis
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Cache/Redis/redis-${var.project_name}-${var.environment}"
}

import {
  to = module.keyvault.random_id.kv_name
  id = "e339"
}

import {
  to = module.keyvault.module.keyvault.azurerm_key_vault.this
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.KeyVault/vaults/kv-${var.project_name}-${var.environment}-e339"
}

import {
  to = module.database.azurerm_private_dns_zone.postgres
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"
}

import {
  to = module.database.azurerm_private_dns_zone_virtual_network_link.postgres
  id = "/subscriptions/${var.subscription_id}/resourceGroups/rg-${var.project_name}-${var.environment}/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/link-postgres-${var.project_name}-${var.environment}"
}
