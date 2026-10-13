variable "location" {
  default = "centralus"
}

variable "resource_group_name" {
  default = "vnet-rg"
}

variable "nsg_name" {
  default = "vnet-nsg"

}

variable "vnet_name" {
  default = "vnet-example"
}

variable "subnet1_name" {
default = "subnet1"
}


variable "subnet2_name" {
default = "subnet2"
}

variable "vnet_address_space" {
  default = "10.0.0.0/16"
  
}

variable "subnet1_address_space" {
  default = "10.0.1.0/24"
}

variable "subnet2_address_space" {
  default = "10.0.2.0/24"
}

variable "dns_servers" {
    description = "List of DNS servers for the virtual network"
    type = list(string)
    default = ["10.0.0.4", "10.0.0.5"]

}

variable "my_public_ip" {
  description = "My public IP address for vnet access"
  type        = string
  default     = "185.26.172.181" #82.117.214.166; 185.26.172.181  185.26.173.46
}

variable "security_rule_name" {
  description = "Name of the security rule that allows inbound traffic from my public IP"
  type        = string
  default     = "AllowAllInbound"
  
}
