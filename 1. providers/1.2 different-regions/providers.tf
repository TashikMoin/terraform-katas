provider "aws" {
  region = var.region_us
  alias  = "us"
}

provider "aws" {
  region = var.region_eu
  alias  = "eu"
}

/* 

Resource creation with different aliases of same provider (AWS) in "same" account.

resource "aws_s3_bucket" "example" {
  provider = aws.eu    <------- specifying the provider (to deploy resource in desired region).
  bucket = "example"
  acl    = "private"
}

 */