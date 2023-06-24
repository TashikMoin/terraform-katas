resource "aws_s3_bucket" "aurora_breeze" {
  provider = aws.default
  bucket = var.bucket
  acl    = "private"
}

resource "azurerm_resource_group" "azure_resource_group" {
  provider = azurerm.default
  name     = var.resource_group
  location = var.region_azure
}