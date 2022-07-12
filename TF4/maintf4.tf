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
  
  subscription_id   = "af3ec114-8f3a-43b2-9bc7-8833c761d44b"
  tenant_id         = "4abcb15f-9fd7-4a13-ac16-3d55a64fa21e"
  client_id         = "f792d999-fbdb-48a8-952b-86b5bebacff2"
  client_secret     = "pHk8Q~nnyJ-FwQLlh9UGlemyabyl_lVYFEtJtda5"
}


resource "azurerm_resource_group" "rg" {
  name      = "MyTF4RG"
  location  = "westeurope"
}