output "api_identity_id" {
  value       = module.identity_api.resource_id
  description = "The resource ID of the API managed identity"
}

output "api_identity_client_id" {
  value       = module.identity_api.client_id
  description = "The client ID of the API managed identity"
}

output "api_identity_principal_id" {
  value       = module.identity_api.principal_id
  description = "The principal ID of the API managed identity"
}

output "gmail_identity_id" {
  value       = module.identity_gmail.resource_id
  description = "The resource ID of the Gmail managed identity"
}

output "gmail_identity_client_id" {
  value       = module.identity_gmail.client_id
  description = "The client ID of the Gmail managed identity"
}

output "gmail_identity_principal_id" {
  value       = module.identity_gmail.principal_id
  description = "The principal ID of the Gmail managed identity"
}

output "ai_identity_id" {
  value       = module.identity_ai.resource_id
  description = "The resource ID of the AI managed identity"
}

output "ai_identity_client_id" {
  value       = module.identity_ai.client_id
  description = "The client ID of the AI managed identity"
}

output "ai_identity_principal_id" {
  value       = module.identity_ai.principal_id
  description = "The principal ID of the AI managed identity"
}

output "rule_engine_identity_id" {
  value       = module.identity_rule_engine.resource_id
  description = "The resource ID of the rule engine managed identity"
}

output "rule_engine_identity_client_id" {
  value       = module.identity_rule_engine.client_id
  description = "The client ID of the rule engine managed identity"
}

output "rule_engine_identity_principal_id" {
  value       = module.identity_rule_engine.principal_id
  description = "The principal ID of the rule engine managed identity"
}

output "meeting_identity_id" {
  value       = module.identity_meeting.resource_id
  description = "The resource ID of the meeting managed identity"
}

output "meeting_identity_client_id" {
  value       = module.identity_meeting.client_id
  description = "The client ID of the meeting managed identity"
}

output "meeting_identity_principal_id" {
  value       = module.identity_meeting.principal_id
  description = "The principal ID of the meeting managed identity"
}
