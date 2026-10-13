################################################ variables used by main.tf ################################################
variable "subscription_id" {
}

variable "serviceprincipal_id" {
}

variable "serviceprincipal_key" {
}

variable "tenant_id" {
}

#Module's vars
variable "location" {
  default = "eastus"
}

variable "ssh_key" {
}

variable "kubernetes_version" {
  default = "1.30.1"
}

################################################ variables used by resource_group module ################################################

variable "rg_name" {
 
}

variable "rg_location" {
}

################################################ variables used by network_security_rule module ################################################


variable "nsg_name" {

}

variable "nsg_location" {

}

variable "nsg_rg_name" {

}

variable "sr_name" {

}

variable "sr_priority" {

  
}

variable "sr_direction" {

  
}

variable "sr_access" {

  
}

variable "sr_protocol" {

  
}

variable "sr_source_port_range" {

  
}

variable "sr_destination_port_range" {

  
}

variable "sr_source_address_prefix" {

  
}

variable "sr_destination_address_prefix" {
  
}

######################################## variables used by vnet module #########################################################

variable "vnet_name" {

}

variable "vnet_rg_name" {

}

variable "vnet_rg_location" {

}

variable "address_space" {

}

######################################### variables used by subnet module ##########################################################

  variable "subnet1_name" {

  }

  variable "subnet1_rg_name" {

  }

  variable "subnet1_vnet_name" {

  }

  variable "subnet1_address_space" {

  }

  variable "subnet2_name" {

  }

  variable "subnet2_rg_name" {

  }

  variable "subnet2_vnet_name" {

  }

  variable "subnet2_address_space" {

  }

  ########################################## variables used by namespace_public_ip_with_nic module ##########################################################

  variable "public_ip1_name" {}
  variable "ip1_allocation_method" {}
  variable "nic1_name" {}
  variable "ip1_configuration_name" {}
  variable "private_ip1_allocation" {}

############################################ variables used by vm module ##########################################################

variable "vm1_name" {
}

variable "vm1_size" {

}
variable "admin_username_for_vm1" {

}

variable "vm1_ssh_public_key_path" {

}
variable "vm1_caching" {

}
variable "vm1_offer" {

}
variable "vm1_sku" {

}
variable "vm1_version" {

}
variable "vm1_application_role_tag" {

}

variable "vm1_sa_type" {

}

variable "vm1_publisher" {

}

  ########################################## variables used by namespace_public_ip_with_nic module ##########################################################

  variable "public_ip2_name" {}
  variable "ip2_allocation_method" {}
  variable "nic2_name" {}
  variable "ip2_configuration_name" {}
  variable "private_ip2_allocation" {}  


############################################ variables used by vm module ##########################################################

variable "vm2_name" {
}

variable "vm2_size" {

}
variable "admin_username_for_vm2" {

}

variable "vm2_ssh_public_key_path" {

}
variable "vm2_caching" {

}
variable "vm2_offer" {

}
variable "vm2_sku" {

}
variable "vm2_version" {

}
variable "vm2_application_role_tag" {

}

variable "vm2_sa_type" {

}

variable "vm2_publisher" {

}

variable "keyvault_name" {
}

variable "keyvault_location" {
}

variable "keyvault_resource_group_name" {
}

variable "SUBSCRIPTION_ID" {
  
}

#variable "public_ip3_name" {}
#variable "ip3_allocation_method" {}
#variable "nic3_name" {}
#variable "ip3_configuration_name" {}
#variable "private_ip3_allocation" {}


#variable "public_ip4_name" {}
#variable "ip4_allocation_method" {}
#variable "nic4_name" {}
#variable "ip4_configuration_name" {}
#variable "private_ip4_allocation" {}

#variable "win_vm2_name" {}
#variable "win_os_disk2_name" {
#}

############################################ variables used by windows vm module ##########################################################

#variable "win_vm_name" {  
#}


#variable "win_admin_username" {
  
#}

#variable "win_admin_password" {
  
#}

#variable "win_computer_name" {
  
#}
#variable "win_vm_publisher" {
  
#}

#variable "win_vm_offer" {

#}

#variable "win_vm_sku" {

#}

#variable "win_vm_version" {

#}

#variable "win_os_disk_name" {

#}

#variable "win_os_disk_caching" {

#}
#variable "win_os_disk_create_option" {
  
#}
#variable "win_os_disk_managed_disk_type" {
  
#}

#variable "win_virtual_machine_size" {
  
#}