variable "prefix" {
  type        = string
  description = "Prefix of the resource name"
  default     = "web-app-docker-acr"
}

variable "environment" {
  type        = string
  description = "Name of the deployment environment"
  default     = "dev"
}


variable "resource_group_location" {
  type        = string
  description = "Location to deploy the resource group"
  
}

variable "resource_group_name" {
   type  = string
  description = "Name to deploy the resource group"
}

variable "dns_prefix" {
  type        = string
  description = "A prefix for any dns based resources"
  default     = "tfq"
}

variable "plan_tier" {
  type        = string
  description = "The tier of app service plan to create"
  default     = "Standard"
}

variable "plan_sku" {
  type        = string
  description = "The sku of app service plan to create"
  default     = "S1"
}

# variable "user_assigned_identity_id" {
#   type        = string
#   description = "The sku of app service plan to create"

# }



# Define ACR credentials as variables for your web app
variable "login_server" {
  description = "ACR login server URL"
 
}

variable "user_name" {
  description = "ACR admin username"

}

variable "password" {
  description = "ACR admin password"
 
}



# Combine base name with random pet name and random string suffix for app name
variable "app_name" {
  description = "The name of the web application with a random pet name and unique suffix"
  default     = "web-app"
}

# Define variables for the ACR login server and the image


variable "acr_repo" {
  description = "The name of the image to use from the Azure Container Registry"
  default = "my-flask-web-app-repo"

}

variable "acr_image_tag" {
  description = "The tag of the image to use from the Azure Container Registry"
  default     = "95" # Change this to a specific tag if needed
}