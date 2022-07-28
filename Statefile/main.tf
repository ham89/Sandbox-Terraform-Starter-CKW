terraform {

  required_version = ">=0.12"

backend "azurerm" {
    resource_group_name  = "statefile-rg"
    storage_account_name = "ststatefile"
    container_name       = "statefilecore"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
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

resource "azurerm_storage_container" "statefile_container_core" {
  name                  = "statefilecore"
  storage_account_name  = azurerm_storage_account.statefile_storage.name
  container_access_type = "private"
}

