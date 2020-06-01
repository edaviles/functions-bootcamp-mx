#######################################
# Variables
#######################################
variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "ARM_TENANT_ID" {}
variable "ARM_ENVIRONMENT" {}



#######################################
# Porviders: Azure, AWS, etc.
#######################################
provider "azurerm" {
        features{}
}

#######################################
# Resources
#######################################
resource "azurerm_resource_group" "rg" {
  name     = "CloudBootcamp"
  location = "eastus"
}

resource "azurerm_storage_account" "storage" {
  name                     = "functionsappmmx1"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "functions-service-plan-mx"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "azurefunction" {
  name                       = "functions-bootcamp-mx"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.appserviceplan.id
  # storage_account_name       = azurerm_storage_account.storage.name
  # storage_account_access_key = 
  storage_connection_string = azurerm_storage_account.storage.primary_connection_string
  version = "~3"

  app_settings = {
      FUNCTIONS_WORKER_RUNTIME = "netcore" 
  }

}