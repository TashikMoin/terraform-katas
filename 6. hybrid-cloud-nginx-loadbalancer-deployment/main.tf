# Source Code: github.com/terraform-in-action/terraform-cloud-vm/tree/v0.2.0/modules/aws
module "aws" {
  source = "terraform-in-action/vm/cloud//modules/aws"
   providers = {
    aws = aws.default
  }
  environment = {
    name             = "AWS"
    background_color = "orange"
  }
}

# Source Code: github.com/terraform-in-action/terraform-cloud-vm/tree/v0.2.0/modules/azure
module "azure" {
  source = "terraform-in-action/vm/cloud//modules/azure"
  location = var.region_azure
   providers = {
    azurerm = azurerm.default
  }
  environment = {
    name             = "Azure"
    background_color = "blue"
  }
}


/*
Instead of deploying loadbalancer docker container using this below load balancer module, you can also deploy loadbalancer container inside your local 
machine manually to send all incoming localhost:5000 requests to these virtual machines on public clouds.

# commands to deploy nginx container load balancer
export addresses="<AWS VM IP>:8080,<AZURE VM IP>:8080,<GCP VM IP>:8080" 
docker run -p 5000:80 -e ADDRESSES=$addresses -dit swinkler/tia-loadbalancer

For now we are deploying the local docker container using terraform.
*/

# Source Code: github.com/terraform-in-action/terraform-cloud-vm/tree/v0.2.0/modules/loadbalancer
module "loadbalancer" {
  source = "terraform-in-action/vm/cloud//modules/loadbalancer"
  addresses = [
    module.aws.network_address,
    module.azure.network_address
  ]
}