variable "principal_arns" {
  description = "A list of principal arns allowed to assume the IAM role"
  default     = null
  type        = list(string)
}
variable "force_destroy_state" {
  description = "Force destroy the s3 bucket containing state files?"
  default     = true
  type        = bool
}

variable "bucket_name" {
  default = "johndoe"
}

variable "bucket_role" {
  default = "johndoe_bucket_role"
}

variable "bucket_role_policy_name" {
  default = "johndoe-role-policy"
}

variable "dynamodb_name" {
  default = "johndoe-bucket-dynamodb"
}