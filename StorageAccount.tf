resource "azurerm_resource_group" "ResourceGroup-POC-RG" {
  name     = "poc-resources"
  location = "eastus"
  tags = {
    Owner = "ramm"
  }
}

resource "azurerm_virtual_network" "VirtualNetwork" {
  name                = "POC-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.ResourceGroup-POC-RG.location
  resource_group_name = azurerm_resource_group.ResourceGroup-POC-RG.name
}

resource "azurerm_subnet" "POC-subnet" {
  name                 = "Subnet-internal"
  resource_group_name  = azurerm_resource_group.ResourceGroup-POC-RG.name
  virtual_network_name = azurerm_virtual_network.VirtualNetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_storage_account" "POC-StorageAccount" {
  name                     = "storageaccountpocterra"
  resource_group_name      = azurerm_resource_group.ResourceGroup-POC-RG.name
  location                 = azurerm_resource_group.ResourceGroup-POC-RG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
 # account_replication_type = "GRS"
  
resource "azurerm_storage_container" "Blob_storage" {
  name                  = "blobgithubactions"
  storage_account_name  = azurerm_storage_account.Blob_storage.name
  container_access_type = "private"
}

  tags = {
    Owner = "ramm"
  }
}
