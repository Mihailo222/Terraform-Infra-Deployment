resource "azurerm_resource_group" "rg_one" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "vnet_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg_one.location
  resource_group_name = azurerm_resource_group.rg_one.name
}



resource "azurerm_network_security_rule" "allow_inbound_from_my_ip" {
    network_security_group_name = azurerm_network_security_group.vnet_nsg.name
    resource_group_name = azurerm_resource_group.rg_one.name

    name                       = var.security_rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*" //3389???
    destination_port_range     = "*"
    source_address_prefix      = var.my_public_ip #my public IP for vnet access
    destination_address_prefix = "*"

}



resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg_one.location
  resource_group_name = azurerm_resource_group.rg_one.name

  address_space       = [var.vnet_address_space]
 # dns_servers         = var.dns_servers #takes a type  of list(string) -> USE AZURE DNS SERVERS INSTEAD, if you want dns services without custom dns server

  /*subnet {
    name             = var.subnet1_name
    address_prefixes = [var.subnet1_address_space]
  }

  subnet {
    name             = var.subnet2_name
    address_prefixes = [var.subnet2_address_space]
    security_group   = azurerm_network_security_group.vnet_nsg.id #attach the NSG to the subnet; here we will deploy vm that needs to be accessed from my public ip
  }*/
}


resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.rg_one.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet1_address_space]
}

resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.rg_one.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet2_address_space]
#  private_endpoint_network_policies = NetworkSecurityGroupEnabled
#  security_group       = azurerm_network_security_group. #attach the NSG to the subnet; here we will deploy vm that needs to be accessed from my public ip
  
}

resource "azurerm_subnet_network_security_group_association" "subnet2_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.vnet_nsg.id
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "my-public-ip"
  resource_group_name = azurerm_resource_group.rg_one.name
  location            = azurerm_resource_group.rg_one.location
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "main_nic" {
  name                = "azure-my-nic"
  location            = azurerm_resource_group.rg_one.location
  resource_group_name = azurerm_resource_group.rg_one.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = azurerm_public_ip.vm_public_ip.id
  }
}

#resource "azurerm_virtual_machine" "my_windows_vm" {
#  name                  = "windowsvm"
#  location              = azurerm_resource_group.rg_one.location
#  resource_group_name   = azurerm_resource_group.rg_one.name
#  network_interface_ids = [azurerm_network_interface.main_nic.id]
#  vm_size               = "Standard_B2s"

#    os_profile_windows_config {
#    provision_vm_agent = true
    #enable_automatic_updates = true
      
#    }

#  os_profile {
#    admin_username        = "azureuser"
#    admin_password        = "Password123"
#    computer_name         = "myvmwindows"
#  }

#  storage_image_reference {
#    publisher = "MicrosoftWindowsServer"
#    offer     = "WindowsServer"
#    sku       = "2022-datacenter-azure-edition"
#    version   = "latest"
#  }

#  storage_os_disk {
#    name              = "myosdisk1_windows_vm"
#    caching           = "ReadWrite"
#    create_option     = "FromImage"
#    managed_disk_type = "Standard_LRS"
#  }
 
#}


resource "azurerm_linux_virtual_machine" "my_vm_one" {
  name                = "myLinuxVM"
  resource_group_name = azurerm_resource_group.rg_one.name
  location            = azurerm_resource_group.rg_one.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main_nic.id
  ]

    depends_on = [
    azurerm_network_interface.main_nic,
    azurerm_public_ip.vm_public_ip
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/Users/mihailomahovac/Desktop/aks-deployment-terraform/aks-deployment/resources/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    applicationRole = "message-broker"
  }
}




# sredi module, razdvoj da svaki modul ima input-output varijable, odradi da svaki modul bude razdvojen, dodaj varijable, dodaj da svaki modul ima zavisnike-dependence, dodaj ga u main.tf i dodaj da se iz main.tf preko tfvars pune
# dodaj da imas npr. za dodavanje vise subnetova peko foreacha 

#THIS MODULE CREATES A VIRTUAL NETWORK WITH TWO SUBNETS, A PUBLIC IP ADDRESS, A NETWORK INTERFACE, AND A WINDOWS VIRTUAL MACHINE
#THE VM IS DEPLOYED IN THE SECOND SUBNET AND IS ACCESSIBLE VIA THE PUBLIC
#IP ADDRESS. THE NSG IS ATTACHED TO THE SECOND SUBNET TO ALLOW INBOUND TRAFFIC FROM MY PUBLIC IP.
#THE FIRST SUBNET IS NOT USED IN THIS EXAMPLE, BUT IT CAN BE USED FOR OTHER PURPOSES.
#THE VM IS CONFIGURED WITH A STATIC PUBLIC IP ADDRESS AND A DYNAMIC
#PRIVATE IP ADDRESS. THE VM IS CONFIGURED WITH A WINDOWS OS PROFILE AND A
#WINDOWS OS DISK. THE VM IS CONFIGURED WITH A STANDARD_B2S VM SIZE AND A STANDARD_LRS MANAGED DISK TYPE.
#THE VM IS CONFIGURED WITH A WINDOWS SERVER 2022 DATACENTER AZURE EDITION IMAGE.
#THE VM IS CONFIGURED WITH A WINDOWS OS PROFILE AND A WINDOWS OS DISK. THE VM IS CONFIGURED WITH A STANDARD_B2S VM SIZE 





# creating 2nd VM


resource "azurerm_public_ip" "vm_public_ip2" {
  name                = "my-public-ip2"
  resource_group_name = azurerm_resource_group.rg_one.name
  location            = azurerm_resource_group.rg_one.location
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "main_nic2" {
  name                = "azure-my-nic2"
  location            = azurerm_resource_group.rg_one.location
  resource_group_name = azurerm_resource_group.rg_one.name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = azurerm_public_ip.vm_public_ip2.id
  }
}

resource "azurerm_linux_virtual_machine" "my_vm_two" {
  name                = "myLinuxVM2"
  resource_group_name = azurerm_resource_group.rg_one.name
  location            = azurerm_resource_group.rg_one.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main_nic2.id
  ]
  depends_on = [
    azurerm_network_interface.main_nic2,
    azurerm_public_ip.vm_public_ip2
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/Users/mihailomahovac/Desktop/aks-deployment-terraform/aks-deployment/resources/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    applicationRole = "webserver"
  }
}


