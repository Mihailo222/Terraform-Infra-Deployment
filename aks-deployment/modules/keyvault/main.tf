data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
    name = var.keyvault_name
    location = var.keyvault_location
    resource_group_name = var.keyvault_resource_group_name
    #senable_for_disk_encryption = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    purge_protection_enabled = false
    sku_name = "standard"
    soft_delete_retention_days = 7
    enabled_for_deployment = true


}