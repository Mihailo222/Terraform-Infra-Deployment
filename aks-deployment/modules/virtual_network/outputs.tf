#  remote_virtual_network_id = module.virtual_network.vnet_id  # output from vnet module

output "vnet_id" {
  description = "Virtual network id."
  value = azurerm_virtual_network.vnet.id
}