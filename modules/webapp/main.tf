# Web App
resource "azurerm_app_service_plan" "appsvcplan" {
  name                = "${lower(var.envprefix)}appserviceplan"
  location            = var.rglocation
  resource_group_name = var.rgname

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "${lower(var.envprefix)}webapp"
  location            = var.rglocation
  resource_group_name = var.rgname
  app_service_plan_id = azurerm_app_service_plan.appsvcplan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION"  = "10.15.2"
    "ApiUrl"                        = "/api/v1"
    "ApiUrlShoppingCart"            = "/api/v1"
    "MongoConnectionString"         = var.mongoconnstr
    "SqlConnectionString"           = var.sqlconnstr
    "productImagesUrl"              = "https://raw.githubusercontent.com/suuus/TailwindTraders-Backend/master/Deploy/tailwindtraders-images/product-detail"
    "Personalizer__ApiKey"          = ""
    "Personalizer__Endpoint"        = ""
  }

}
