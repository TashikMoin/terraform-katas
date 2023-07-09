/*
This particular code creates a least-privileged IAM role that another AWS account can assume to deploy against the S3 backend. 
To clarify, all of the state files will be stored in an S3 bucket created by the S3 backend, so at a minimum, we expect deployment 
users to need permissions to put objects in S3. Additionally, they will need permissions to get/delete records from the DynamoDB
table that manages locking.
*/


/*
The "aws_caller_identity" data source is used to retrieve information about the entity making the API request to AWS, also known as the "caller identity".
By using this data source, you can access details about the AWS account, IAM user, or IAM role associated with the current execution context.
*/
data "aws_caller_identity" "current" {}


# "A list of principal arns allowed to assume the IAM role"
locals {
  principal_arns = var.principal_arns != null ? var.principal_arns : [data.aws_caller_identity.current.arn]
}

resource "aws_iam_role" "iam_role" {
  name               = var.bucket_role
  assume_role_policy = <<-EOF
 {
 "Version": "2012-10-17",
 "Statement": [
 {
 "Action": "sts:AssumeRole",
 "Principal": {
 "AWS": ${jsonencode(local.principal_arns)}
 },
 "Effect": "Allow"
 }
 ]
 }
 EOF
}


data "aws_iam_policy_document" "policy_doc" {
  /* 
  The first 2 statements grant permission for the "ListBucket", "s3:GetObject", "s3:PutObject", "s3:DeleteObject" action, which enables the user to retrieve a list 
  of s3 buckets, get | update | delete objects contained within a specific S3 bucket, identified by the ARN specified in the "resources" array.
  */
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn
    ]
  }

  # Giving more permissions to s3
  statement {
    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*", #\
    ]
  }

  /*
  This statement allows the user to perform "GetItem," "PutItem," and "DeleteItem" actions within a specified DynamoDB table, 
  identified by the ARN provided in the "resources" array.
  */
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [aws_dynamodb_table.dynamodb_table.arn]
  }

  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = [aws_kms_key.kms_key.arn]
  }
}


resource "aws_iam_policy" "iam_policy" {
  name   = var.bucket_role_policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.policy_doc.json
}


resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

