output "nsg_id" {
  description = "Network security group id"
  value = azurerm_network_security_group.vnet_nsg.id
}