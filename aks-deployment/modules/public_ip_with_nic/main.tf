resource "azurerm_public_ip" "vm_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = var.allocation_method
}


resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id  = azurerm_public_ip.vm_public_ip.id
  }
}