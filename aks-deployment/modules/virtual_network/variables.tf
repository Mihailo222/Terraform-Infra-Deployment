variable "vnet_name" {
  
  type = string
  description = "Virtual network name" 

}

variable "rg_name" {
  type = string
  description = "Resource group name"
}

variable "rg_location" {
  type = string
  description = "Resource group location"
}

variable "address_space" {
  type = string
  description = "Address space of virtual network"
}