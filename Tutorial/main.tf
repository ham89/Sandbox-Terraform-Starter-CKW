terraform {

  backend "azurerm" {
    resource_group_name  = "statefile-rg"
    storage_account_name = "ststatefile"
    container_name       = "statefile"
    key                  = "terraform.tfstate"
  }

  required_version = ">=0.12"

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

resource "azurerm_resource_group" "rg" {
  name     = "tutorial-rg"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tutorial-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }

}

resource "azurerm_subnet" "subnet" {
  #name                 = "tutorial-snet"
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.123.1.0/24"]
}

