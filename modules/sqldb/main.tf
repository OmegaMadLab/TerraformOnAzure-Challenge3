# Azure SQL DB
resource "azurerm_sql_server" "sqlsrv" {
  name                         = "${lower(var.envprefix)}sqlsrv"
  location                     = var.rglocation
  resource_group_name          = var.rgname
  version                      = "12.0"
  administrator_login          = var.dbuid
  administrator_login_password = var.dbpwd
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "${lower(var.envprefix)}sqldb"
  server_id      = azurerm_sql_server.sqlsrv.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 1
  sku_name       = "Basic"
}

resource "azurerm_sql_firewall_rule" "sqlfwrule" {
  name                = "${lower(var.envprefix)}sqlfw-AzureServicesOn"
  resource_group_name = var.rgname
  server_name         = azurerm_sql_server.sqlsrv.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

