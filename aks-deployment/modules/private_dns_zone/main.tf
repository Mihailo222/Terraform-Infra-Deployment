resource "azurerm_private_dns_zone" "aks_dns" {
  name                = var.private_dns_zone_name 
  resource_group_name = var.resource_group_name 
}