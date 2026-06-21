variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. dev, prod)"
}

variable "meeting_principal_id" {
  type        = string
  description = "The principal ID of the meeting managed identity"
}

variable "queue_name" {
  type        = string
  description = "The name of the Service Bus queue to create"
  default     = "meeting-reminders"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the Service Bus resources"
}
