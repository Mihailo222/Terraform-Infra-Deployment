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
variable "vm_size" {
    type        = string
    description = "Virtual machine size."
}
variable "admin_username" {
    type        = string
    description = "Admin username."
}
variable "nic_id" {
    type        = string
    description = "Network interface id."
}
variable "ssh_public_key_path" {
    type        = string
    description = "Public key file path."
}
variable "vm_caching" {
    type        = string
    description = "Virtual machine caching."
}
variable "vm_offer" {
    type        = string
    description = "Virtual machine offer."
}
variable "vm_sku" {
    type        = string
    description = "Vitual machine sku."
}
variable "vm_version" {
    type        = string
    description = "Virtual machine version."
}
variable "application_role" {
    type        = string
    description = "Application role tag for the VM."
}

variable "sa_type" {
  type = string
  description = "Storage account type for the OS disk."
}

variable "vm_publisher" {
  type = string
  description = "Virtual machine publisher."
}
