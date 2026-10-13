variable "public_ip_name" {
  type = string
  description = "Public IP address name"
}
variable "rg_name" {
  type = string
  description = "Resource group name"
}

variable "rg_location" {
  type = string
  description = "Location where the resources will be created"
}

variable "allocation_method" {
  type = string
  description = "Allocation method for the public IP address (Static or Dynamic)"
}

variable "nic_name" {
  type = string
  description = "Network Interface Card name"
}

variable "ip_configuration_name" {
  type = string
  description = "IP configuration name for the NIC"
  
}

variable "subnet_id" {
  type = string
  description = "Subnet ID where the NIC will be connected"
  
}

variable "private_ip_allocation" {
  type = string
  description = "Private IP address allocation method (Static or Dynamic)"
  
}
