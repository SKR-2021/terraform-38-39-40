
data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["444663524611"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "open_vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/open_vpn_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}