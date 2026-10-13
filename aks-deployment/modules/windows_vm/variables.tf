variable "vm_name" {
    type        = string
    description = "Name of the virtual machine."
}
variable "rg_location" {
    type        = string
    description = "Resource group location."
}
variable "rg_name" {
    type        = string
    description = "Name of resource group."
}

variable "nic_id" {
    type        = string
    description = "Network interface id."
}

variable "vm_size" {
    type        = string
    description = "Virtual machine size."
  
}

variable "admin_uname" {
    type        = string
    description = "Admin username."
  
}

variable "admin_passwd" {
    type        = string
    description = "Admin password."
  
}

variable "comp_name" {
    type        = string
    description = "Computer name."
}

variable "virtual_machine_size" {
    type        = string
    description = "Size of the virtual machine."
}

variable "vm_publisher" {
  type = string
  description = "Virtual machine publisher."
}   

variable "vm_offer" {
  type = string
  description = "Virtual machine offer."
}

variable "vm_sku" {
  type = string
  description = "Virtual machine sku."
}

variable "vm_version" {
  type = string
  description = "Virtual machine version."
}

variable "os_disk_name" {
  type = string
  description = "Name of the OS disk."
  
}

variable "os_disk_caching" {
  type = string
  description = "Caching type of the OS disk."
  
}

variable "os_disk_create_option" {
  type = string
  description = "Create option for the OS disk."
  
}

variable "os_disk_managed_disk_type" {
  type = string
  description = "Managed disk type for the OS disk."

}
