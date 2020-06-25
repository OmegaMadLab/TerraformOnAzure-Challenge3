output "mongoconnstr" {
  value = "mongodb://${var.dbuid}:${var.dbpwd}@${azurerm_container_group.mongoaci.fqdn}:27017"
}