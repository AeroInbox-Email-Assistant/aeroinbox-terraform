output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.log.id
  description = "The resource ID of the Log Analytics Workspace"
}

output "log_analytics_workspace_key" {
  value       = azurerm_log_analytics_workspace.log.primary_shared_key
  description = "The primary shared key of the Log Analytics Workspace"
  sensitive   = true
}

output "app_insights_id" {
  value       = azurerm_application_insights.appi.id
  description = "The resource ID of the Application Insights resource"
}

output "app_insights_connection_string" {
  value       = azurerm_application_insights.appi.connection_string
  description = "The connection string of the Application Insights resource"
  sensitive   = true
}

output "app_insights_instrumentation_key" {
  value       = azurerm_application_insights.appi.instrumentation_key
  description = "The instrumentation key of the Application Insights resource"
  sensitive   = true
}
