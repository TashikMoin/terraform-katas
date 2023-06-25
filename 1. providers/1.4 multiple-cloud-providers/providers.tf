provider "aws" {
  region = var.region_aws
  alias = "default"
}

provider "azurerm" {
  alias = "default"
  features {} 
  # leaving empty to use default provider behavior
}

provider "random" {}