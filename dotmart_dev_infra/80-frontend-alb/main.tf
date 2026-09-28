resource "aws_lb" "frontend_alb" {
  name               = "${local.comman_name_suffix}-backend-alb" # dotmart-dev-backend-alb
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false


  tags = merge(
    local.common_tags,
    {
      Name = "${local.comman_name_suffix}-frontend-alb"
    }
  )
}

resource "aws_lb_listener" "frontend_alb" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = local.frontend_alb_certification_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> THIS IS FROM HTTPS FRONTEND-ALB</h1>"
      status_code  = "200"
    }

  }
}