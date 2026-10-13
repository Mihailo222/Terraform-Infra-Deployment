  variable "subnet_name" {
    type = string
    description = "Subnet name"
  }

  variable "rg_name" {
    type = string
    description = "Resource group name"
  }

  variable "vnet_name" {
    type = string
    description = "Vnet name"
  }

  variable "subnet_address_space" {
    type = string
    description = "Address space for a sbnet."
  }