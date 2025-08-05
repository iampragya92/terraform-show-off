terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.28.0"
    }
  }

   backend "azurerm" {
    storage_account_name  = "aibasedtodo"
    resource_group_name   = "rg-backend"
    container_name        = "terraformstatefiles"
    key                   = "dev.terraformstatefiles"
  }
}



provider "azurerm" {

  features {}
  subscription_id = "1f196f8e-ab8f-4746-a1f5-1798c2228e8f"

}