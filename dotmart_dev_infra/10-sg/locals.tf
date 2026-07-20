locals {
    comman_name_suffix = "${var.project_name}-${var.environment}" # dotmart-dev
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}