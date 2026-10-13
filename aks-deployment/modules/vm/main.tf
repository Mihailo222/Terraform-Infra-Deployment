resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    var.nic_id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${var.ssh_public_key_path}")
  }

  os_disk {
    caching              = var.vm_caching
    storage_account_type = var.sa_type
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  tags = {
    applicationRole = var.application_role
  }
}