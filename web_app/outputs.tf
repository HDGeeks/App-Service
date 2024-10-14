# Output principal_id and tenant_id
output "flask_web_app_principal_id" {
  value = azurerm_app_service.flask-web-app.identity[0].principal_id
  description = "The principal ID of the system-assigned managed identity for the Flask web app."
}

output "flask_web_app_tenant_id" {
  value = azurerm_app_service.flask-web-app.identity[0].tenant_id
  description = "The tenant ID associated with the system-assigned managed identity for the Flask web app."
}

output "staging_slot_app_principal_id" {
  value = azurerm_app_service_slot.slotDemo.identity[0].principal_id  
  description = "The principal ID of the system-assigned managed identity for the staging slot."
}