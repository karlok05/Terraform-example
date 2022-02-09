resource "azurerm_app_service_plan" "service_plan" {
  name                = "example-appserviceplan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "example-app-service"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id
  https_only          = true

  app_settings = {
    "ENVIRONMENT" = "test"
  }

  connection_string {
    name  = "Database connection"
    type  = "PostgreSQL"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}