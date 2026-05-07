terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

resource "azurerm_resource_group" "ping" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.ping.name
  location            = azurerm_resource_group.ping.location
  acr_name            = var.acr_name
  tags                = var.tags
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.ping.name
  location            = azurerm_resource_group.ping.location
  cluster_name        = var.cluster_name
  node_vm_size        = var.node_vm_size
  node_count          = var.node_count
  acr_id              = module.acr.acr_id
  tags                = var.tags
}

module "namespaces" {
  source     = "./modules/namespaces"
  depends_on = [module.aks]
}
