resource "aws_kms_key" "kms_key" {
  description = "KMS for state backend bucket encryption."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : data.aws_caller_identity.current.arn
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
    ]
  })
}