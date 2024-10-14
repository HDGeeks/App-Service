resource "random_string" "acr_suffix" {
  length  = 8
  upper   = false
  lower   = true
  special = false
}



resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${random_string.acr_suffix.result}"  
  //name = "cgi-demo-acr"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  admin_enabled       = true

 }




