output "service_principal_name" {
  description = "The name of the service principal"
  value       = azuread_service_principal.main.display_name
}

output "service_principal_id" {
  description = "The ID of the service principal"
  value       = azuread_service_principal.main.object_id
}

output "service_principal_key" {
  description = "The key of the service principal"
  value       = azuread_service_principal_password.main.value
}

output "service_principal_tenant_id" {
  description = "The tenant ID of the service principal"
  value = azuread_service_principal.main.application_tenant_id
}

output "client_id" {
  description = "The client ID of the service principal"
  value = azuread_application.main.client_id
}

output "client_secret" {
  description = "Password for the service principal"
  value       = azuread_service_principal_password.main.value
}