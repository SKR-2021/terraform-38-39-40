locals {
  comman_name_suffix             = "${var.project_name}-${var.environment}" # dotmart-dev
  vpc_id                         = data.aws_ssm_parameter.vpc_id.value
  frontend_alb_sg_id             = data.aws_ssm_parameter.frontend_alb_sg_id.value
  public_subnet_ids              = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  frontend_alb_certification_arn = data.aws_ssm_parameter.frontend_alb_certification_arn.value

  common_tags = {
    Project_name = var.project_name
    Environment  = var.environment
    Terraform    = true
  }
}