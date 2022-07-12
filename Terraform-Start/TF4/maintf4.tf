terraform {


  required_version = ">=0.12"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}




provider "azurerm" {
  features {}
  
  subscription_id   = "<subscription_id>"
  tenant_id         = "<tenant_id>"
  client_id         = "<service_principal_appid>"
  client_secret     = "<service_principal_password>"
}




resource "azurerm_resource_group" "rg" {
  name      = "MyTF4RG"
  location  = "westeurope"
}