output "resource_group_id" {
  description = "ID of a resource group."
  value = azurerm_resource_group.rg.id
}

output "name" {
  description = "Name of the resource group."
  value = azurerm_resource_group.rg.name
  
}

output "location" {
  description = "Location of the resource group."
  value = azurerm_resource_group.rg.location
  
}