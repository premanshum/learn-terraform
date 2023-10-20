terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      version = "~> 3.76.0"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  subscription_id   = ""
  tenant_id         = ""
  client_id         = ""
  client_secret     = ""
}