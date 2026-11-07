terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfsaccsa"
    container_name       = "terraform-tfstate-container"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "current" {}

############################################# calling resource group module #####################################################

module "resource_group" {
    source = "./modules/resource_group"
    rg_name = var.rg_name
    rg_location = var.rg_location
}

############################################# calling network security group module ##############################################

module "namespace_network_security_group" {
    depends_on = [ module.resource_group ]
    source = "./modules/network_security_group"
    nsg_name = var.nsg_name
    nsg_location = var.rg_location
    nsg_rg_name = var.rg_name
    sr_name = var.sr_name
    sr_priority = var.sr_priority
    sr_direction = var.sr_direction
    sr_access = var.sr_access
    sr_protocol = var.sr_protocol
    sr_source_port_range = var.sr_source_port_range
    sr_destination_port_range = var.sr_destination_port_range
    sr_source_address_prefix = var.sr_source_address_prefix
    sr_destination_address_prefix = var.sr_destination_address_prefix 
}

############################################# calling virtual network module #####################################################


module "virtual_network" {
  depends_on = [ module.resource_group ]
  source = "./modules/virtual_network"
  vnet_name = var.vnet_name
  rg_name = var.vnet_rg_name
  rg_location = var.vnet_rg_location
  address_space = var.address_space
}

############################################# calling subnet1 module #####################################################

module "subnet_one" {

  depends_on = [ module.resource_group, module.virtual_network ]

  source = "./modules/subnet"

  subnet_name = var.subnet1_name
  rg_name = var.subnet1_rg_name
  vnet_name = var.subnet1_vnet_name
  subnet_address_space = var.subnet1_address_space

}

############################################# calling subnet2 module #####################################################

module "subnet_two" {

  depends_on = [ module.resource_group, module.virtual_network ]

  source = "./modules/subnet"

  subnet_name = var.subnet2_name
  rg_name = var.subnet2_rg_name
  vnet_name = var.subnet2_vnet_name
  subnet_address_space = var.subnet2_address_space

}

############################################# calling subnet nsg association module #####################################################

module "nsg_subnet_association" {

  depends_on = [ module.namespace_network_security_group, module.subnet_two ]
  source = "./modules/subnet_nsg_association"
  subnet_id = module.subnet_two.subnet_id #output from subnet_two module -> subnet_id
  nsg_id = module.namespace_network_security_group.nsg_id #output from nsg module -> nsg_id

}

############################################# calling nic1 module #####################################################

module "namespace_public_ip_with_nic_for_vm1" {

  depends_on = [ module.resource_group, module.subnet_two ]

  source = "./modules/public_ip_with_nic"

  public_ip_name = var.public_ip1_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  allocation_method = var.ip1_allocation_method
  nic_name = var.nic1_name
  ip_configuration_name = var.ip1_configuration_name
  subnet_id = module.subnet_two.subnet_id
  private_ip_allocation = var.private_ip1_allocation
  
}

############################################# calling vm module #####################################################

module "virtual_machine_1" {
  source = "./modules/vm"
  depends_on = [ module.namespace_public_ip_with_nic_for_vm1 ]
    vm_name = var.vm1_name
    rg_name = var.rg_name
    rg_location = var.rg_location
    vm_size = var.vm1_size
    admin_username = var.admin_username_for_vm1
    ssh_public_key_path = var.vm1_ssh_public_key_path
    nic_id = module.namespace_public_ip_with_nic_for_vm1.nic_id
    vm_caching = var.vm1_caching
    sa_type = var.vm1_sa_type
    vm_publisher = var.vm1_publisher
    vm_offer = var.vm1_offer
    vm_sku = var.vm1_sku
    vm_version = var.vm1_version
    application_role = var.vm1_application_role_tag
}

############################################# calling nic2 module #####################################################

module "namespace_public_ip_with_nic_for_vm2" {

  depends_on = [ module.resource_group, module.subnet_two ]

  source = "./modules/public_ip_with_nic"

  public_ip_name = var.public_ip2_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  allocation_method = var.ip2_allocation_method
  nic_name = var.nic2_name
  ip_configuration_name = var.ip2_configuration_name
  subnet_id = module.subnet_two.subnet_id
  private_ip_allocation = var.private_ip2_allocation
  
}

############################################# calling vm2 module #####################################################

module "virtual_machine_2" {
  source = "./modules/vm"
  depends_on = [ module.namespace_public_ip_with_nic_for_vm2 ]
    vm_name = var.vm2_name
    rg_name = var.rg_name
    rg_location = var.rg_location
    vm_size = var.vm2_size
    admin_username = var.admin_username_for_vm2
    ssh_public_key_path = var.vm2_ssh_public_key_path
    nic_id = module.namespace_public_ip_with_nic_for_vm2.nic_id
    vm_caching = var.vm2_caching
    sa_type = var.vm2_sa_type
    vm_publisher = var.vm2_publisher
    vm_offer = var.vm2_offer
    vm_sku = var.vm2_sku
    vm_version = var.vm2_version
    application_role = var.vm2_application_role_tag
}

############################################# calling windows_vm module #####################################################

# DOMAIN CONTROLLER VM
/*module "namespace_public_ip_with_nic_for_vm3" {

  depends_on = [ module.resource_group, module.subnet_two ]

  source = "./modules/public_ip_with_nic"

  public_ip_name = var.public_ip3_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  allocation_method = var.ip3_allocation_method
  nic_name = var.nic3_name
  ip_configuration_name = var.ip3_configuration_name
  subnet_id = module.subnet_two.subnet_id
  private_ip_allocation = var.private_ip3_allocation

}*/


/*module "windows_virtual_machine" {
   
  source = "./modules/windows_vm"
  depends_on = [ module.namespace_public_ip_with_nic_for_vm3 ]
  vm_name = var.win_vm_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  vm_size = var.win_virtual_machine_size
  nic_id = module.namespace_public_ip_with_nic_for_vm3.nic_id 
  admin_uname = var.win_admin_username
  admin_passwd = var.win_admin_password
  comp_name = var.win_computer_name
  vm_publisher = var.win_vm_publisher
  vm_offer = var.win_vm_offer
  vm_sku = var.win_vm_sku
  vm_version = var.win_vm_version
  os_disk_name = var.win_os_disk_name
  os_disk_caching = var.win_os_disk_caching
  os_disk_create_option = var.win_os_disk_create_option
  os_disk_managed_disk_type = var.win_os_disk_managed_disk_type
  virtual_machine_size = var.win_virtual_machine_size

}*/


# JOINED VM
/*module "namespace_public_ip_with_nic_for_vm4" {

  depends_on = [ module.resource_group, module.subnet_two ]

  source = "./modules/public_ip_with_nic"

  public_ip_name = var.public_ip4_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  allocation_method = var.ip4_allocation_method
  nic_name = var.nic4_name
  ip_configuration_name = var.ip4_configuration_name
  subnet_id = module.subnet_two.subnet_id
  private_ip_allocation = var.private_ip4_allocation

}*/


/*module "windows_virtual_machine2" {
   
  source = "./modules/windows_vm"
  depends_on = [ module.namespace_public_ip_with_nic_for_vm4 ]
  vm_name = var.win_vm2_name
  rg_name = var.rg_name
  rg_location = var.rg_location
  vm_size = var.win_virtual_machine_size
  nic_id = module.namespace_public_ip_with_nic_for_vm4.nic_id 
  admin_uname = var.win_admin_username
  admin_passwd = var.win_admin_password
  comp_name = var.win_computer_name
  vm_publisher = var.win_vm_publisher
  vm_offer = var.win_vm_offer
  vm_sku = var.win_vm_sku
  vm_version = var.win_vm_version
  os_disk_name = var.win_os_disk2_name
  os_disk_caching = var.win_os_disk_caching
  os_disk_create_option = var.win_os_disk_create_option
  os_disk_managed_disk_type = var.win_os_disk_managed_disk_type
  virtual_machine_size = var.win_virtual_machine_size

}*/

# deploying AKS cluster with terraform 
############ LETS DO THIS #################

module "ServicePrincipal" {
  source = "./modules/service_principal"
}

resource "azurerm_role_assignment" "rolespn" {
  scope = "/subscriptions/${var.SUBSCRIPTION_ID}"
  role_definition_name = "Contributor"
  principal_id = module.ServicePrincipal.service_principal_id
  depends_on = [ module.ServicePrincipal ]
}






# Dedicated Resource Group for DNS
resource "azurerm_resource_group" "dns_rg" {
  name     = "dns-resource-group"
  location = "East US"
}

# Private DNS Zone
resource "azurerm_private_dns_zone" "aks_dns" {
  name                = "privatelink.eastus.azmk8s.io"
  resource_group_name = azurerm_resource_group.dns_rg.name
}

# Link DNS Zone to AKS VNet
#resource "azurerm_private_dns_zone_virtual_network_link" "aks_link" {
#  name                  = "aks-vnet-link"
#  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
#  resource_group_name   = azurerm_resource_group.dns_rg.name
#  registration_enabled = false
#  virtual_network_id   = module.aks_cluster.aks_vnet_id
#  depends_on = [ module.aks_cluster, azurerm_private_dns_zone.aks_dns ]
#}

# Link DNS Zone to VM VNet
resource "azurerm_private_dns_zone_virtual_network_link" "vm_link" {
  name                  = "vm-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
  virtual_network_id    = module.virtual_network.vnet_id
  resource_group_name   = azurerm_resource_group.dns_rg.name
  registration_enabled = false

  depends_on = [ module.virtual_network, azurerm_private_dns_zone.aks_dns ]
}





module "aks_cluster" { # assign AKS cluster with appropriate dns zone !
  source = "./modules/cluster"
  #SP client ID and client secret !!!
  serviceprincipal_id = module.ServicePrincipal.client_id  #client id
  serviceprincipal_key = module.ServicePrincipal.client_secret #client secret
  tenant_id = var.tenant_id

  private_dns_zone_id = azurerm_private_dns_zone.aks_dns.id

  depends_on = [ azurerm_role_assignment.rolespn, module.ServicePrincipal, azurerm_private_dns_zone.aks_dns ]
}




#module "keyvault" {
#  source                      = "./modules/keyvault"
#  keyvault_name               = var.keyvault_name
#  keyvault_location                    = var.keyvault_location
#  keyvault_resource_group_name = module.resource_group.id
#  service_principal_name      = module.ServicePrincipal.service_principal_name
#  service_principal_object_id = module.ServicePrincipal.service_principal_object_id
#  service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id

#  depends_on = [
#    module.ServicePrincipal, module.resource_group
#  ]

#}

#resource "azurerm_key_vault_secret" "example" {
#  name         = module.ServicePrincipal.client_id
#  value        = module.ServicePrincipal.client_secret
#  key_vault_id = module.keyvault.keyvault_id

#  depends_on = [
#    module.keyvault
#  ]
#}


# creating site to point vpn gateway 

# subnet for vpn gw
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.vnet_rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.255.0/27"]
}

# public ip for vpn gw

resource "azurerm_public_ip" "vpn_gateway_ip" {
  name                = "vpn-gateway-public-ip"
  location            = var.vnet_rg_location # do we need AKS location ??
  resource_group_name = var.vnet_rg_name

  allocation_method = "Static"
  sku               = "Standard"
}


# vpn gateway

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = "vm-vnet-vpn-gateway"
  location            = var.vnet_rg_location
  resource_group_name = var.vnet_rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1AZ"

  active_active = false
  bgp_enabled   = false

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vpn_gateway_ip.id
    subnet_id            = azurerm_subnet.gateway_subnet.id
  }

  vpn_client_configuration {
    address_space = ["172.25.0.0/24"]

    vpn_client_protocols = ["OpenVPN"]
    vpn_auth_types       = ["AAD"]

    aad_tenant = "https://login.microsoftonline.com/${var.tenant_id}/"

    aad_audience = "c632b3df-fb67-4d84-bdcf-b95ad541b5c8"

    aad_issuer = "https://sts.windows.net/${var.tenant_id}/"
  }
}


# creating vnet peering between aks cluster vnet and existing vnet
# VNet peering is created on in boath RGs for boath vnets in rg where vn_name is !!!

resource "azurerm_virtual_network_peering" "vms-to-aks" {
  name                      = "vms-to-aks"
  resource_group_name       = var.rg_name
  virtual_network_name      = var.vnet_name
  remote_virtual_network_id = module.aks_cluster.aks_vnet_id  #output from aks module 

  allow_virtual_network_access = true
  allow_gateway_transit        = true

  depends_on = [ module.aks_cluster, module.virtual_network, azurerm_virtual_network_gateway.vpn_gateway ]
}

resource "azurerm_virtual_network_peering" "aks-to-vms" {
  name                      = "aks-to-vms"
  resource_group_name       = module.aks_cluster.aks_resource_group_name #rg od aks_vnet_name
  virtual_network_name      = module.aks_cluster.aks_vnet_name  # output is rg modula
  remote_virtual_network_id = module.virtual_network.vnet_id  # output from vnet module

  allow_virtual_network_access = true
  use_remote_gateways          = true

  depends_on = [ module.aks_cluster, module.virtual_network, azurerm_virtual_network_gateway.vpn_gateway ]
}