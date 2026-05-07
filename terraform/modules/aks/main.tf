resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  sku_tier            = "Free"

  default_node_pool {
    name       = "pfengine"
    node_count = 1
    vm_size    = var.node_vm_size

    node_labels = {
      role = "pf-engine"
    }

    upgrade_settings {
      max_surge = "1"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "pf_admin" {
  name                  = "pfadmin"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.node_vm_size
  node_count            = 1

  node_labels = {
    role = "pf-admin"
  }

  node_taints = [
    "role=pf-admin:NoSchedule"
  ]

  upgrade_settings {
    max_surge = "1"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "pingdirectory" {
  name                  = "pingdir"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D4s_v3"
  node_count            = 1

  node_labels = {
    role = "pingdirectory"
  }

  node_taints = [
    "role=pingdirectory:NoSchedule"
  ]

  upgrade_settings {
    max_surge = "1"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}
