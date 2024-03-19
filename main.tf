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
  location = "eastus2"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "kubernetes_cluster"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
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

resource "azurerm_container_registry" "container_registry" {
  name                     = "acrlanchonete"
  resource_group_name      = azurerm_resource_group.resource.name
  location                 = azurerm_resource_group.resource.location
  sku                      = "Premium"
  admin_enabled            = false  
}

resource "azurerm_role_assignment" "acr_role" {
  scope                = azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id  
  skip_service_principal_aad_check = true
}