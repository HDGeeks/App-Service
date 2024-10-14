

resource "random_pet" "prefix" {
  prefix = var.prefix
  length = 2
}

# Generate a random string of 6 characters for uniqueness
resource "random_string" "app_name" {
  length  = 6
  special = false
}
resource "azurerm_app_service_plan" "webapp-plan" {
  name                = "${random_pet.prefix.id}-plan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  

  # Reserved must be set to true for Linux App Service Plans
  reserved = true

  sku {
    tier = var.plan_tier
    size = var.plan_sku
    capacity = "2"
  }
}

locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "${var.login_server}"
   DOCKER_REGISTRY_SERVER_USERNAME       = "${var.user_name}"
   DOCKER_REGISTRY_SERVER_PASSWORD       = "${var.password}"
   WEBSITES_PORT                         = "${var.port}"
 }
  app_name = "${var.app_name}-${random_string.app_name.result}"
  image_reference = "${var.login_server}/${var.acr_repo}:${var.acr_image_tag}"
}

# Create the Azure App Service with the random name
resource "azurerm_app_service" "flask-web-app" {
  name                = local.app_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.webapp-plan.id
  https_only          = true

  identity {
    type         = "SystemAssigned"
    #identity_ids = [var.user_assigned_identity_id]
  }

  site_config {
    always_on                        = true
    acr_use_managed_identity_credentials = true
    scm_type                        = "VSTSRM"
    linux_fx_version                    = "DOCKER|${local.image_reference}"
  }

  app_settings = local.env_variables
}

resource "azurerm_app_service_slot" "slotDemo" {
    name                = "staging"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    app_service_plan_id = azurerm_app_service_plan.webapp-plan.id
    app_service_name    = azurerm_app_service.flask-web-app.name
    https_only = true

     identity {
    type         = "SystemAssigned"
    #identity_ids = [var.user_assigned_identity_id]
  }

   
  site_config {
    always_on                        = true
    acr_use_managed_identity_credentials = true
    scm_type                        = "VSTSRM"
    linux_fx_version                    = "DOCKER|${local.image_reference}"
  }

    app_settings = local.env_variables

    
}



resource "azurerm_role_assignment" "acr_pull_assignment" {
  principal_id         = azurerm_app_service.flask-web-app.identity[0].principal_id  
  role_definition_name = "AcrPull"
  scope                = var.acr_id  
}

resource "azurerm_role_assignment" "staging_acr_pull_assignment" {
  principal_id         = azurerm_app_service_slot.slotDemo.identity[0].principal_id  
  role_definition_name = "AcrPull"
  scope                = var.acr_id  
}

