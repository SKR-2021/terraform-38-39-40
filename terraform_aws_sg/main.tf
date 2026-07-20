resource "aws_security_group" "main" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = merge(
    var.sg_tags,
    local.comman_tags,
    {
        Name = "${local.comman_name_suffix}-${var.sg_name}-sg" # dotmart-dev-catalogue-sg
    }
  )
}