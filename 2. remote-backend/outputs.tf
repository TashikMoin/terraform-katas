output "config" {
  value = {
    bucket         = module.backend.config.bucket
    role_arn       = module.backend.config.role_arn
    dynamodb_table = module.backend.config.dynamodb_table
  }
}