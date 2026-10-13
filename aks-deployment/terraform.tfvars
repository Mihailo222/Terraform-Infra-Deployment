# Resource group
rg_name = "vnet-rg"
rg_location = "centralus"

# VNet / subnets
vnet_name = "vnet-example"
vnet_rg_name = "vnet-rg"
vnet_rg_location = "centralus"
address_space = "10.0.0.0/16"

subnet1_name = "subnet1"
subnet1_vnet_name = "vnet-example"
subnet1_rg_name = "vnet-rg"
subnet1_address_space = "10.0.1.0/24"

subnet2_name = "subnet2"
subnet2_vnet_name = "vnet-example"
subnet2_rg_name = "vnet-rg"
subnet2_address_space = "10.0.2.0/24"

# NSG and rule
nsg_name = "vnet-nsg"
nsg_location = "centralus"
nsg_rg_name = "vnet-rg"

sr_name = "allow-inbound-from-my-ip"
sr_priority = 100
sr_direction = "Inbound"
sr_access = "Allow"
sr_protocol = "Tcp"
sr_source_port_range = "*"
sr_destination_port_range = "22"
sr_source_address_prefix = "82.117.214.166"
sr_destination_address_prefix = "*"

# Public IPs / NICs
public_ip1_name = "vm-public-ip"
ip1_allocation_method = "Static"
nic1_name = "vm-nic"
ip1_configuration_name = "ipconfig1"
private_ip1_allocation = "Dynamic"

public_ip2_name = "vm-public-ip-2"
ip2_allocation_method = "Static"
nic2_name = "vm-nic-2"
ip2_configuration_name = "ipconfig2"
private_ip2_allocation = "Dynamic"

# VM1
vm1_name = "vm-one"
vm1_size = "Standard_F2"
admin_username_for_vm1 = "adminuser"
#vm1_ssh_public_key_path = "/Users/mihailomahovac/Desktop/aks-deployment-terraform/aks-deployment/resources/id_rsa.pub"
vm1_caching = "ReadWrite"
vm1_publisher = "Canonical"
vm1_offer = "0001-com-ubuntu-server-jammy"
vm1_sku = "22_04-lts"
vm1_version = "latest"
vm1_application_role_tag = "message-broker"
vm1_sa_type = "Standard_LRS"

# VM2
vm2_name = "vm-two"
vm2_size = "Standard_F2"
admin_username_for_vm2 = "adminuser"
#vm2_ssh_public_key_path = "/Users/mihailomahovac/Desktop/aks-deployment-terraform/aks-deployment/resources/id_rsa.pub"
vm2_caching = "ReadWrite"
vm2_publisher = "Canonical"
vm2_offer = "0001-com-ubuntu-server-jammy"
vm2_sku = "22_04-lts"
vm2_version = "latest"
vm2_application_role_tag = "message-broker"
vm2_sa_type = "Standard_LRS"

SUBSCRIPTION_ID="d625e1d8-8605-4e47-a941-00e7ddb795a2"
#keyvault
keyvault_name = "example-keyvault"
keyvault_location = "centralus"
keyvault_resource_group_name = "vnet-rg"

# Windows placeholders (adjust if used)
#win_vm_name = ""
#win_admin_username = "azureuser"
#win_admin_password = "REPLACE_WITH_SECURE_PASSWORD"
#win_computer_name = ""
#win_vm_publisher = ""
#win_vm_offer = ""
#win_vm_sku = ""
#win_vm_version = ""
#win_os_disk_name = ""
