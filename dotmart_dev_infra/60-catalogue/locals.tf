locals {
  common_name_suffix = "${var.project_name}-${var.environment}" # dotmart-dev
  ami_id             = data.aws_ami.dotmart.id
  catalogue_sg_id    = data.aws_ssm_parameter.catalogue_sg_id.value
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
  vpc_id             = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Terraform   = "true"
  }
}