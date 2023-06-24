resource "aws_s3_bucket" "johndoe_bucket_us" {
  provider = aws.eu
  bucket = "johndoe-us"
  acl    = "private"
}

resource "aws_s3_bucket" "johndoe_bucket_eu" {
  provider = aws.eu
  bucket = "johndoe-eu"
  acl    = "private"
}