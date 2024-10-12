
terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./resource_group"
  resource_group_name = "Serverless-Demo"
  location            = "Germany West Central"
}

# module "identity" {
#   source = "./managed_identity"
#   resource_group_name = module.resource_group.resource_group_name
#   location            = module.resource_group.resource_group_location
#   identity_name       = "container-identity"
# }



module "acr" {

  source               = "./acr"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  acr_name              = "myacrregistry"

  
}

module "webapp" {

  source = "./web_app"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  login_server = module.acr.acr_login_server
  user_name = module.acr.acr_admin_username
  password = module.acr.acr_admin_password
  
}




output "server" {
  value = module.acr.acr_login_server
  
}
output "user" {
  value = module.acr.acr_admin_username
  
}
# output "password" {
#   value = module.acr.acr_admin_password
  
# }
