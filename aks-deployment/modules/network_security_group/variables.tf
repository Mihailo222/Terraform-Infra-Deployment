variable "nsg_name" {
  description = "Network security group name"
    type        = string
}

variable "nsg_location" {
  description = "Resource group name where the network security group will be created"
    type        = string
}

variable "nsg_rg_name" {
  description = "Location where the network security group will be created. Expected - resource group location"
    type        = string 
}

variable "sr_name" {
  description = "Security rule name"
    type        = string
}

variable "sr_priority" {
  description = "Security rule priority"
    type        = number
  
}

variable "sr_direction" {
  description = "Security rule direction"
    type        = string
  
}

variable "sr_access" {
  description = "Security rule access"
    type        = string
  
}

variable "sr_protocol" {
  description = "Security rule protocol"
    type        = string
  
}

variable "sr_source_port_range" {
  description = "Security rule source port range"
    type        = string
  
}

variable "sr_destination_port_range" {
  description = "Security rule destination port range"
    type        = string
  
}

variable "sr_source_address_prefix" {
  description = "Security rule source address prefix"
    type        = string
  
}

variable "sr_destination_address_prefix" {
  description = "Security rule destination address prefix"
    type        = string    
}