resource "kubernetes_namespace" "ping_dev" {
  metadata {
    name = "ping-dev"
    labels = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
