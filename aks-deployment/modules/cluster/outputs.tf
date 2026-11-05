output "aks_vnet_id" {
  description = "AKS virtual network id"
  value = azurerm_virtual_network.aks_vnet.id
}

output "aks_vnet_name" {
  description = "AKS virtual network name"
  value = azurerm_virtual_network.aks_vnet.name
}