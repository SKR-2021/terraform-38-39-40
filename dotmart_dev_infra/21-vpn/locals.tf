locals {
  ami_id            = data.aws_ami.openvpn.id
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  open_vpn_sg_id    = data.aws_ssm_parameter.open_vpn_sg_id.value
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Terraform   = "true"
  }
}