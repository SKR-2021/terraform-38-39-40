module "vpc" {
  # source       = "../terraform_aws_vpc_main_module"
  source       = "git::https://github.com/SKR-2021/terraform-35-36-37.git//terraform_aws_vpc_main_module"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment
  vpc_tags     = var.vpc_tags
  
  # Public Subnets
  public_subnet_cidrs =  var.public_subnet_cidrs

   # Private Subnets
  private_subnet_cidrs =  var.private_subnet_cidrs

   # Database Subnets
  database_subnet_cidrs =  var.database_subnet_cidrs

  is_peering_required = false
}
