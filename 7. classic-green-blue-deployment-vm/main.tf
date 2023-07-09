module "base" {
 source = "terraform-in-action/aws/bluegreen//modules/base"
 production = var.production
}

module "green" {
 source = "terraform-in-action/aws/bluegreen//modules/autoscaling"
 app_version = "v1.0"
 label = "green"
 base = module.base
}

module "blue" {
 source = "terraform-in-action/aws/bluegreen//modules/autoscaling"
 app_version = "v2.0"
 label = "blue"
 base = module.base
}


# Reference to these modules: https://github.com/terraform-in-action/terraform-bluegreen-aws/tree/v0.1.3/modules