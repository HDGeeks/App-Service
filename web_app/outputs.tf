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
  value = azurerm_app_service_slot.stagingSlot.identity[0].principal_id  
  description = "The principal ID of the system-assigned managed identity for the staging slot."
}

# Output for the assigned role of the main Azure App Service
output "main_app_service_acr_pull_assignment" {
  value = {
    principal_id         = azurerm_role_assignment.acr_pull_assignment.principal_id
    role_definition_name = azurerm_role_assignment.acr_pull_assignment.role_definition_name
    scope                = azurerm_role_assignment.acr_pull_assignment.scope
  }
}

# Output for the assigned role of the staging slot
output "staging_slot_acr_pull_assignment" {
  value = {
    principal_id         = azurerm_role_assignment.staging_acr_pull_assignment.principal_id
    role_definition_name = azurerm_role_assignment.staging_acr_pull_assignment.role_definition_name
    scope                = azurerm_role_assignment.staging_acr_pull_assignment.scope
  }
}