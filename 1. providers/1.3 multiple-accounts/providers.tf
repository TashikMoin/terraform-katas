/* 

Step # 1 (configure aws profiles)

open ~/.aws/credentials file and add profiles for all your accounts.

[profile_name_account_1]
aws_access_key_id = ACCESS_KEY_ACCOUNT_1
aws_secret_access_key = SECRET_KEY_ACCOUNT_1

[profile_name_account_2]
aws_access_key_id = ACCESS_KEY_ACCOUNT_2
aws_secret_access_key = SECRET_KEY_ACCOUNT_2




Step # 2 (use profile attribute inside provider block)

provider "aws" {
  region = var.region_us
  alias  = "us"
  profile = <profile_name_account_1>          <------------ configuring provider with desired account/profile.
}

provider "aws" {
  region = var.region_eu
  alias  = "eu"
  profile = <profile_name_account_2>          <------------ configuring provider with desired account/profile.
}

provider "random" {}



Resource creation with different aliases of same provider (AWS) in "different" accounts.

resource "aws_s3_bucket" "example" {
  provider = aws.eu    <-------  specifying the provider (to deploy resources in desired region, and account/profile).
  bucket = "example"
  acl    = "private"
}

 */