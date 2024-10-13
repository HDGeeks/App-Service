
# Output ACR login server URL, admin username, and admin password
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
  description = "The ACR login server URL."
}

output "acr_admin_username" {
  value = azurerm_container_registry.acr.admin_username
  description = "The admin username for the ACR."
}

output "acr_admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  description = "The admin password for the ACR."
  //sensitive   = true  # Mark it as sensitive so it's hidden in the output
}

output "acr_id" {
  value = azurerm_container_registry.acr.id 
  
}