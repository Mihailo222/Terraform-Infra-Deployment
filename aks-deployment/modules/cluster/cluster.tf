resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-test-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "example_cluster" {
  name                = "exercises-aks"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "exerciseaks"
  #kubernetes_version = var.kubernetes_version

  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "Standard_E4s_v3"
    type = "VirtualMachineScaleSets"
    os_disk_size_gb = 250
  }

# service principal we need it for deployment od k8s cluster. Svc principal needs to have a contributor permissions set
  service_principal {
    client_id = var.serviceprincipal_id
    client_secret = var.serviceprincipal_key
  }
  
  #linux profile needed every time the node pool is VM scale set
  linux_profile { 
    admin_username = "azureuser"
    ssh_key {
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBKy1CQJ19EmDEivOXzANvEyvEQLzY7yOUhD0fSOs6qb0vvhZZAnk00C7sxN1CJ39leaVCug2X9YPFTUte9r4v7XoAd/MHyv8+P0Tz+9aQdXLYGSoWs8yEuyAe9e3Ntt+csreHa72AWKlbOQCzoIvv10BzTuDCI4hOExQVSId2xHrA+Zhgn3mBHkftyazitfzoKZ5nElB0Y4TSI6My0gmKFayvlRKJx4/wtWXXkxrqtufIdyFdRUP62RbMbHFCulsSaUlzr4IjMD66cU+JBJrVSHxt1CpbAaTDUMVA3jbE1mqpuFx5KF15goiKKjSKr7OPcC0ApHzRku/b3Ipc6FgfnZCxiLXVITG0o0AzDi32AGr4ed7xk7y3oeTXv2aEUyZOXA9S7sDrk3Jvmw39uK4LLYIMQ6qTo+Hk9+0qq/jOm2I93olT834mgTetHtKB1daxjp3vj/YPB5jEDza3KqbMiz4XTi3Xsj/TAlC8EfHvkPiMUuk6/9USS5WRErcwJ+W9tCX6PkeLEkf8ezdPO9IiuOmlLX//uLpXlC2uJIJKDBUagyAUE46OkpXQDfwm0rhEz5JCa+hMXOrJbTXtIi1c0lcMgJl+3hlktXVzDyVbkZDHYpTlx+EnyyAGbyMJJwYcNwgSvWfYpcPJkP9OryJoGM/kPBc7O5ggo2xw8rzozw== mymail@gmailexample.com"
      // read this from a file !!!
    }
  }

  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
  }


  //azure_policy_enabled = false

  http_application_routing_enabled = false

 # How to enable aad integration on a cluster ??

 #ENABLE AZURE RBAC AUTHENTICATION
 azure_active_directory_role_based_access_control {
    tenant_id = var.tenant_id # when you want azure_rbac_enabled, this tenant id must be set. Kao ako nije specified, onda ce od current subscriptiona biti, mada meni se tf zali ako nema tenant_id ja spec.
    azure_rbac_enabled = true
 }

  # HOW TO ENABLE K8S RBAC AUTHENTICATION
   local_account_disabled = true

  #support_plan = "AKSLongTermSupport" # for my version is necessary
}