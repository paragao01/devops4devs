terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aula_rg" {
    name     = "aula-rg"
    location = "East US"
}

resource "azurerm_kubernetes_cluster" "aula_k8s" {
  name                = "aula_k8s"
  location            = azurerm_resource_group.aula_rg.location
  resource_group_name = azurerm_resource_group.aula_rg.name
  dns_prefix          = "aulak8s"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "local_file" "k8s_config" {
  content  = "foo!"
  filename = "${path.module}/foo.bar"
}