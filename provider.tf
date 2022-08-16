terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.15.0"
    }
  }
}

provider "azurerm" {
  # Loại bỏ hard code sub_id
  subscription_id = var.sub_id
  features {

  }
}