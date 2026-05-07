output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_get_credentials_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.ping.name} --name ${module.aks.cluster_name} --overwrite-existing"
}
