output "sqlconnstr" {
  value = "Server=tcp:${azurerm_sql_server.sqlsrv.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sqldb.name};Persist Security Info=False;User ID=${var.dbuid};Password=${var.dbpwd};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}