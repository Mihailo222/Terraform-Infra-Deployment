resource "azurerm_private_dns_zone_virtual_network_link" "vm_link" {

  name                  = var.link_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
  registration_enabled  = false
  
}
