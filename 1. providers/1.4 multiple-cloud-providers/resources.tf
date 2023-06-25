resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "aurora_breeze" {
  provider = aws.default
  bucket = "${var.bucket}-${random_id.bucket_suffix.hex}"
  acl    = "private"
}

resource "azurerm_resource_group" "azure_resource_group" {
  provider = azurerm.default
  name     = var.resource_group
  location = var.region_azure
}