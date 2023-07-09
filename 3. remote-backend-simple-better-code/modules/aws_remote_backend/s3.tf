resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy_state
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.kms_key.arn
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true # it prevents any ACLs from granting public access.
  block_public_policy     = true # it prevents the use of bucket policies that allow public access.
  ignore_public_acls      = true # it ensures that any existing public ACLs are not considered during the evaluation of bucket access.
  restrict_public_buckets = true # it blocks public access via new buckets creation.
}