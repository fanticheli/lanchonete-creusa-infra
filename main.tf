terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.14.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource" {
  name     = "resource_lanchonete"
  location = "brazilsouth"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "kubernetes_cluster"
  location            = "brazilsouth"
  resource_group_name = "resource_lanchonete"
  dns_prefix          = "lanchonete-creusa"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}