terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.11"
    }
  }
}

provider "aws" {
  alias = "default"
  region = var.region_aws
}

provider "azurerm" {
  alias = "default"
  features {}
  # leaving empty to use default provider behavior
}