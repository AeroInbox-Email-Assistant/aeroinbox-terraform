output "acr_id" {
  value       = module.acr.resource_id
  description = "The resource ID of the container registry"
}

output "acr_login_server" {
  value       = module.acr.resource.login_server
  description = "The login server URL of the container registry"
}

output "acr_name" {
  value       = module.acr.name
  description = "The name of the container registry"
}
