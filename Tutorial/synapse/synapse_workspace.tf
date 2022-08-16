terraform {
}

resource "azurerm_resource_group" "rg-synapse" {
  name     = "rg-synapse2"
  location = "West Europe"
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "dlsynapseaxpotest" {
  name                     = "dlsynapseaxpotest2"
  resource_group_name      = azurerm_resource_group.rg-synapse.name
  location                 = azurerm_resource_group.rg-synapse.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "filesystem" {
  name               = "filesystem"
  storage_account_id = azurerm_storage_account.dlsynapseaxpotest.id
}

resource "azurerm_synapse_workspace" "synapseaxpotest" {
  name                                 = "synapseaxpotest2"
  resource_group_name                  = azurerm_resource_group.rg-synapse.name
  location                             = azurerm_resource_group.rg-synapse.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.filesystem.id
  #managed_resource_group_name          = join("", ["managedrg-", azurerm_synapse_workspace.name])
  managed_resource_group_name          = "managedrg-synapseaxpotest2"
  managed_virtual_network_enabled      = true
  sql_administrator_login              = "sqladminuser"
  sql_administrator_login_password     = "H@Sh1CoR3!"


  identity {
    type = "SystemAssigned"
  }

  tags = {
    Env = "production"
  }

  aad_admin {
    login     = "ced-onAzure-KeyVault-Admins"
    object_id = "255ec374-00c2-4985-8232-f45aef08d81e"
    tenant_id = "4abcb15f-9fd7-4a13-ac16-3d55a64fa21e"

  }

}

resource "azurerm_synapse_managed_private_endpoint" "synapse-endpoint" {
  name                 = "synapse-endpoint"
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  target_resource_id   = azurerm_storage_account.dlsynapseaxpotest.id
  subresource_name     = "dfs"

  depends_on = [azurerm_synapse_firewall_rule.firewallrule1]
}


resource "azurerm_synapse_role_assignment" "synapseadmins" {
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  role_name            = "Synapse Administrator"
  principal_id         = "255ec374-00c2-4985-8232-f45aef08d81e"

  depends_on = [azurerm_synapse_firewall_rule.firewallrule1]
}


resource "azurerm_synapse_firewall_rule" "firewallrule1" {
  name                 = "CKW-zScaler1"
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  start_ip_address     = "165.225.94.1"
  end_ip_address       = "165.225.95.254"
}

resource "azurerm_synapse_firewall_rule" "firewallrule2" {
  name                 = "CKW-Gast"
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  start_ip_address     = "213.173.160.158"
  end_ip_address       = "213.173.160.158"
}

resource "azurerm_synapse_firewall_rule" "firewallrule3" {
  name                 = "CKW-intern"
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  start_ip_address     = "195.225.61.1"
  end_ip_address       = "195.225.61.1"
}

resource "azurerm_synapse_firewall_rule" "firewallrule4" {
  name                 = "CKW-zScaler2"
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  start_ip_address     = "147.161.246.1"
  end_ip_address       = "147.161.247.254"
}

resource "azurerm_synapse_firewall_rule" "AllowAllWindowsAzureIps" {
  name                 = "AllowAllWindowsAzureIps"
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}


/*
resource "azurerm_synapse_workspace_sql_aad_admin" "synapseaxpotestaadadmin" {
  synapse_workspace_id = azurerm_synapse_workspace.synapseaxpotest.id
  login                = "AzureAD Admin"
  object_id            = "255ec374-00c2-4985-8232-f45aef08d81e"
  tenant_id            = "4abcb15f-9fd7-4a13-ac16-3d55a64fa21e"
}

*/