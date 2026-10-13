variable "rg_name" {
  default = "vnet-rg"
  type = string
  description = "Name of the ressource group."
}

variable "rg_location" {
  default = "centralus"
  type = string
  description = "Azure location for all resources."
}

