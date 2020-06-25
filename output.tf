output "rgname" {
    value = azurerm_resource_group.rg.name
}

output "webappname" {
    value = module.webapp.webappname
}