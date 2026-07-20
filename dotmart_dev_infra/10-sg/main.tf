module "catalogue" {
    source = "terraform-aws-modules/security-group/aws"


    name            = "${local.comman_name_suffix}-catalogue-sg"
    use_name_prefix = false
    description     = "Security Group for catalogue with custom ports"
    vpc_id          =  data.aws_ssm_parameter.vpc_id.value 

}

