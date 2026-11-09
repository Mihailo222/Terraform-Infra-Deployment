output "private_dns_zone_name" {
  value = var.private_dns_zone_name
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.aks_dns.id
  
}