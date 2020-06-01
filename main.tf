provider "azurerm" {
        features{}
        subscription_id = var.sub_id
        client_id       = "${var.client_id}"
        client_secret   = "${var.client_secret}"
        tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "rg" {
  name     = "CloudBootcamp"
  location = "eastus"
}