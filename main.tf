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
