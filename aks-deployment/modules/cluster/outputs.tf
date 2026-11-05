output "aks_vnet_id" {
  description = "AKS virtual network id"
  value = azurerm_virtual_network.aks_vnet.id
}