resource "azurerm_virtual_machine" "windows_vm" {
  name                  = var.vm_name
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = [var.nic_id]
  vm_size               =  var.virtual_machine_size #"Standard_B2s"

    os_profile_windows_config {
    provision_vm_agent = true
   # enable_automatic_updates = true
      
    }

  os_profile {
    admin_username        = var.admin_uname     //"azureuser"
    admin_password        = var.admin_passwd                //"Password123"
    computer_name         = var.comp_name                   //"myvmwindows"
  }

  storage_image_reference {
    publisher = var.vm_publisher #"MicrosoftWindowsServer"
    offer     = var.vm_offer     #"WindowsServer"
    sku       = var.vm_sku       #"2022-datacenter-azure-edition"
    version   = var.vm_version   #"latest"
  }

  storage_os_disk {
    name              = var.os_disk_name #"myosdisk1_windows_vm"
    caching           = var.os_disk_caching #"ReadWrite"
    create_option     = var.os_disk_create_option #"FromImage"
    managed_disk_type = var.os_disk_managed_disk_type #"Standard_LRS"
  }
 
}