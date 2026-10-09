resource "aws_instance" "openvpn" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.open_vpn_sg_id]
  subnet_id              = local.public_subnet_ids
  user_data              = file("vpn.sh")


  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-openvpn-vm"
    }
  )
}

resource "aws_route53_record" "openvpn" {
  zone_id         = data.aws_route53_zone.main.zone_id
  name            = "openvpn.${var.domain_name}" # openvpn.dso86s.xyz
  type            = "A"
  ttl             = 1
  records         = [aws_instance.openvpn.public_ip]
  allow_overwrite = true
}
