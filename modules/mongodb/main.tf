# Cosmos in container
resource "azurerm_container_group" "mongoaci" {
  name                = "${lower(var.envprefix)}mongoaci"
  location            = var.rglocation
  resource_group_name = var.rgname
  ip_address_type     = "public"
  dns_name_label      = "${lower(var.envprefix)}mongoaci-omegamadlab"
  os_type             = "Linux"

  container {
    name   = "${lower(var.envprefix)}-mongodb"
    image  = "mongo:latest"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 27017
      protocol = "TCP"
    }

    environment_variables = {
      MONGO_INITDB_ROOT_USERNAME = var.dbuid
      MONGO_INITDB_ROOT_PASSWORD = var.dbpwd
    }
  }
}

