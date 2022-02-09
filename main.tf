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
    sql_connection_string = module.postgres_sql.sql_connection_string
    sql_db_name = module.postgres_sql.sql_db_name
    sql_pass = module.postgres_sql.sql_pass
    sql_username = module.postgres_sql.sql_user

    depends_on = [azurerm_resource_group.karlotest,module.postgres_sql]
}



module "postgres_sql"{
    source = "./modules/azure_postgres_sql"
    resource_group_name = azurerm_resource_group.karlotest.name
    resource_group_location = azurerm_resource_group.karlotest.location

    depends_on = [
      azurerm_resource_group.karlotest
    ]
}