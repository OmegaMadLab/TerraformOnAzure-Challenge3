terraform {
  backend "azurerm" {
    resource_group_name   = "TerraformOnAzure-TfState3"
    storage_account_name  = "tfonazure384332304"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "null" {
}

# RG
resource "azurerm_resource_group" "rg" {
  name      = "${lower(var.envprefix)}RG"
  location  = var.location
}

# Azure SQL DB
module "sqldb" {
  source      = "./modules/sqldb"
  rgname      = azurerm_resource_group.rg.name
  rglocation  = azurerm_resource_group.rg.location
  envprefix   = var.envprefix
  dbuid       = var.dbuid
  dbpwd       = var.dbpassword
}

# Mongo on ACI
module "mongodb" {
  source      = "./modules/mongodb"
  rgname      = azurerm_resource_group.rg.name
  rglocation  = azurerm_resource_group.rg.location
  envprefix   = var.envprefix
  dbuid       = var.dbuid
  dbpwd       = var.dbpassword
}

# WebApp
module "webapp" {
  source       = "./modules/webapp"
  rgname       = azurerm_resource_group.rg.name
  rglocation   = azurerm_resource_group.rg.location
  envprefix    = var.envprefix
  sqlconnstr   = module.sqldb.sqlconnstr
  mongoconnstr = module.mongodb.mongoconnstr
}

# Auto deployment configuration
resource "null_resource" "azure-cli" {

  provisioner "local-exec" {
      command = "az webapp deployment source config --branch master --name $webappname --repo-url $repourl --resource-group $resourcegroup"

      environment = {
          webappname    = module.webapp.webappname
          resourcegroup = azurerm_resource_group.rg.name
          repourl       = var.repourl
      }
  }
}


