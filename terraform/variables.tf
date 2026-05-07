variable "resource_group_name" {
  type    = string
  default = "ping-lab-rg"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "cluster_name" {
  type    = string
  default = "ping-lab-aks"
}

variable "acr_name" {
  type    = string
  default = "pinglabacr"
}

variable "node_vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "node_count" {
  type    = number
  default = 3
}

variable "tags" {
  type = map(string)
  default = {
    environment = "lab"
    project     = "ping-platform"
    managed_by  = "terraform"
  }
}
