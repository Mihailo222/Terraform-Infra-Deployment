resource "azurerm_network_security_group" "vnet_nsg" {
  name                = var.nsg_name
  location            = var.nsg_location
  resource_group_name = var.nsg_rg_name
}

resource "azurerm_network_security_rule" "allow_inbound_from_my_ip" {
    network_security_group_name = azurerm_network_security_group.vnet_nsg.name
    resource_group_name = var.nsg_rg_name

    name                       = var.sr_name
    priority                   = var.sr_priority
    direction                  = var.sr_direction
    access                     = var.sr_access
    protocol                   = var.sr_protocol
    source_port_range          = var.sr_source_port_range
    destination_port_range     = var.sr_destination_port_range
    source_address_prefix      = var.sr_source_address_prefix
    destination_address_prefix = var.sr_destination_address_prefix

}

