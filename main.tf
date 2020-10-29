provider "azurerm" {
    version = "2.5.0"
    features {}
}
terraform {
    backend "azurerm" {
        resource_group_name  = "terraform_demo_resgrp"
        storage_account_name = "ganstorageterraform"
        container_name       = "terraformstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "resource_gp"{
    name="terraform_cont_resgrp"
    location = "eastus"

    tags = {
        Owner="x2gshett"
    }
}
resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.resource_gp.location
  resource_group_name       = azurerm_resource_group.resource_gp.name

  ip_address_type     = "public"
  dns_name_label      = "binarythistlewa"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "vgshettigar/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}