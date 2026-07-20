# Open Source Module 
# module "catalogue" {
#     source = "terraform-aws-modules/security-group/aws"


#     name            = "${local.comman_name_suffix}-catalogue-sg"
#     use_name_prefix = false
#     description     = "Security Group for catalogue with custom ports"
#     vpc_id          =  data.aws_ssm_parameter.vpc_id.value 

# }


module "sg" {
    count = length(var.sg_names)
    source = "git::https://github.com/SKR-2021/terraform-38-39-40.git//terraform_aws_sg"
    project_name    =   var.project_name  
    environment     =   var.environment
    sg_name         =   var.sg_names[count.index]
    sg_description  =   "Created for ${var.sg_names[count.index]}"
    vpc_id          =   local.vpc_id

}