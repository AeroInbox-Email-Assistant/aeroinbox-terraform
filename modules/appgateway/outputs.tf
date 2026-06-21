output "appgw_id" {
  value       = azurerm_application_gateway.appgw.id
  description = "The resource ID of the Application Gateway"
}

output "appgw_name" {
  value       = azurerm_application_gateway.appgw.name
  description = "The name of the Application Gateway"
}

output "appgw_public_ip" {
  value       = azurerm_public_ip.appgw.id
  description = "The resource ID of the public IP of the Application Gateway"
}

output "appgw_public_ip_address" {
  value       = azurerm_public_ip.appgw.ip_address
  description = "The public IP address of the Application Gateway"
}
