output "servicebus_namespace_id" {
  value       = module.servicebus_namespace.resource_id
  description = "The resource ID of the Service Bus namespace"
}

output "servicebus_namespace_name" {
  value       = "sb-${var.project_name}-${var.environment}"
  description = "The name of the Service Bus namespace"
}

output "servicebus_endpoint" {
  value       = module.servicebus_namespace.resource.endpoint
  description = "The primary endpoint URL of the Service Bus namespace"
}

output "servicebus_queue_name" {
  value       = azurerm_servicebus_queue.meeting_reminders.name
  description = "The name of the Service Bus queue"
}
