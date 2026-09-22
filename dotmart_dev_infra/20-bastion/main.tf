resource "aws_instance" "bastion" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_ids
  iam_instance_profile = aws_iam_instance_profile.bastion.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
}

  user_data = file("bastion.sh")
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-bastion-vm"
    }
  )
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = "BastionTerraformAdmin"
}
