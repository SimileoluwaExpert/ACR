terraform {
    backend "azurerm"{ 
        resource_group_name = "DevTestRG"
        storage_account_name = "devstatefileaccount"
        container_name = "tfstate"
        key = "acr.terraform.state"
    }
}
provider "azurerm" {
  version = "~> 2.0"
  skip_provider_registration = "true"
  features {}
}
data "azurerm_resource_group" "acr_resource_group" {
     name     = "${var.name}RG"
    
}
resource "azurerm_container_registry" "acr" {
    name                = "${var.name}lagosacr"
    resource_group_name = data.azurerm_resource_group.acr_resource_group.name
    location            = var.location
    sku                 = "Standard"
    admin_enabled       = false
  
}