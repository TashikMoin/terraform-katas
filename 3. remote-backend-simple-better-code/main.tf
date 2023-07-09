resource "random_id" "bucket_suffix" {
  byte_length = 4
}

module "backend" {
  source = "./modules/aws_remote_backend"
  # Feed value to module inputs/variables here.
  bucket_name             = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
  bucket_role             = var.bucket_role
  bucket_role_policy_name = var.bucket_role_policy_name
  dynamodb_name           = var.dynamodb_name
}


terraform {
  backend "s3" {
    bucket         = "foobar-4022a91e"
    key            = "remote_backend/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    role_arn     = "arn:aws:iam::670558309057:role/foobar_bucket_role"
    dynamodb_table = "foobar-bucket-dynamodb"
  }
}



# This code will not work!
# One limitation of Terraform is that it does not support the use of variables within the configuration of the state backend.
/*
terraform {
  backend "s3" {
    bucket         = output.config.bucket
    key            = "remote_backend/terraform.tfstate"
    region         = var.region
    encrypt        = true
    kms_key_id     = output.config.role_arn
    dynamodb_table = output.config.dynamodb_table
  }
}
*/