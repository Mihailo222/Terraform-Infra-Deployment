data "azurerm_client_config" "current" {}

resource "azuread_application" "main" {
  display_name = "aks-service-principal"
  owners       = [data.azurerm_client_config.current.object_id]
}

resource "azuread_service_principal" "main" {
  app_role_assignment_required = true
  client_id = azuread_application.main.client_id
  owners = [data.azurerm_client_config.current.object_id]
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.id
}



#  application_id = azuread_application.main.application_id


