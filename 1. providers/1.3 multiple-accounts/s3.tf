resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "johndoe_bucket_us" {
  provider = aws.us
  bucket = "${var.bucket_us}-${random_id.bucket_suffix.hex}"
  acl    = "private"
}

resource "aws_s3_bucket" "johndoe_bucket_eu" {
  provider = aws.eu
  bucket = "${var.bucket_eu}-${random_id.bucket_suffix.hex}"
  acl    = "private"
}