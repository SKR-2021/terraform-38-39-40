resource "aws_security_group_rule" "frontend_frontend_alb" {
    type = "ingress" 
    security_group_id = module.sg[9].sg_id
    source_security_group_id   = module.sg[11].sg_id
    from_port         = 80
    protocol       = "tcp"
    to_port           = 80
}
