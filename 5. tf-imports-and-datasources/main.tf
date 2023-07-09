# data source
/*
data "azurerm_storage_account" "johndoe" {
  name                = ""
  resource_group_name = ""
}

output "storage_account_tier" {
  value = data.azurerm_storage_account.johndoe.account_tier
}
*/



# terraform import
/*
resource "azurerm_storage_account" "johndoe" {
  name                     = ""
  resource_group_name      = azurerm_resource_group.johndoe.name
  location                 = azurerm_resource_group.johndoe.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
*/