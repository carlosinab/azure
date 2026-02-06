terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.58"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-azurelab-sysres"
    # Replace with your actual storage account name from step 1
    storage_account_name = "tfstazurelabsysres1493"  
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    # Use environment variable for access_key: ARM_ACCESS_KEY
  }
}

provider "azurerm" {
  features {}
  
  # Use OIDC authentication via Managed Identity
  use_oidc = true
  
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # location        = "Switzerland North"
}