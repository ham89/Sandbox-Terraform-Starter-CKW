terraform {

  backend "azurerm" {
    resource_group_name    = "statefile-rg"
    storage_account_name   = "ststatefile"
    container_name = "statefile"
    key                    = "terraform.tfstate"
  }

}