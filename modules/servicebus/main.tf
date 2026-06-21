module "servicebus_namespace" {
  source  = "Azure/avm-res-servicebus-namespace/azurerm"
  version = "0.4.0"

  name                = "sb-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_servicebus_queue" "meeting_reminders" {
  name         = var.queue_name
  namespace_id = module.servicebus_namespace.resource_id
}

resource "azurerm_role_assignment" "meeting_sender" {
  scope                = module.servicebus_namespace.resource_id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = var.meeting_principal_id
}

resource "azurerm_role_assignment" "meeting_receiver" {
  scope                = module.servicebus_namespace.resource_id
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = var.meeting_principal_id
}
