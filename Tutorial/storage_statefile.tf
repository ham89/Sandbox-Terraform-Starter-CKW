terraform {

}


resource "azurerm_resource_group" "statefile-rg" {
  name     = "statefile-rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "statefile_storage" {
  name                     = "ststatefile"
  resource_group_name      = azurerm_resource_group.statefile-rg.name
  location                 = azurerm_resource_group.statefile-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "statefile_container" {
  name                  = "statefile"
  storage_account_name  = azurerm_storage_account.statefile_storage.name
  container_access_type = "private"
}

