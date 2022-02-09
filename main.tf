provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "karlotest" {
  name     = "karlotest"
  location = "West Europe"
}

module "app_service" {
    source = "./modules/azure_app_service"
    resource_group_name = azurerm_resource_group.karlotest.name
    resource_group_location = azurerm_resource_group.karlotest.location
}

module "postgres_sql"{
    source = "./modules/azure_postgres_sql"
    resource_group_name = azurerm_resource_group.karlotest.name
    resource_group_location = azurerm_resource_group.karlotest.location
}