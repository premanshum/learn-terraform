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
  
  subscription_id   = "df43b9ea-cec5-46f2-ace2-622430cfc26d"
  tenant_id         = "05d75c05-fa1a-42e7-9cf1-eb416c396f2d"
  client_id         = "eec83b7b-fb97-4af5-a989-ffcd18e8df9d"
  client_secret     = "rIt8Q~DAU-ALHl30UIyqG~dVtLz~qeMdSTYVGdm4"
}