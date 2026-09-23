resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-catalogue-vm" # dotmart-dev-catalogue-vm
    }
  )
}

# Connect to instance using remote-exec provisioner through terraform_data
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  # Terraform copies this file to catalogue server
  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/catalogue.sh",
      # "sudo sh /tmp/catalogue.sh"
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"

    ]
  }
}

# Stop the instance to take image (AMI)
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on  = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on         = [aws_ec2_instance_state.catalogue]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-catalogue-ami" # dotmart-dev-catalogue-vm
    }
  )
}

resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name_suffix}-catalogue-ami"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = 2
    interval            = 2
    matcher             = 200 - 299
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 2

  }
}

resource "aws_launch_template" "catalogue" {
  name     = "${local.common_name_suffix}-catalogue-template"
  image_id = "aws_ami_from_instance.catalogue.id"

  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t3.micro"

  vpc_security_group_ids = [local.catalogue_sg_id]

  # Tags attached to the instance
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name : "${local.common_name_suffix}-catalogue-template"
      }
    )
  }
  # Tags attached to the volume created by instance
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name : "${local.common_name_suffix}-catalogue-template"
      }
    )
  }
  # Tags attached to the lauch template
  tags = merge(
    local.common_tags,
    {
      Name : "${local.common_name_suffix}-catalogue-template"
    }
  )
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name_suffix}-catalogue-asg"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }
  vpc_zone_identifier = local.private_subnet_ids
  target_group_arns = [aws_lb_target_group.catalogue.arn]

  dynamic "tag" {     # we will get the iterator with name as tag 
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue"
      }
    )

    content {
      key                 = "tag.key"
      value               = "tag.value"
      propagate_at_launch = true
    }
  }
  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "example" {
  autoscaling_group_name = "aws_autoscaling_group.catalogue.name"
  name                   = "${local.common_name_suffix}-catalogue-plcy"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0
  }

}

resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_suffix}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = [local.private_subnet_ids]

  enable_deletion_protection = false


  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name_suffix}-backend-alb"
    }
  )
}

# Backend ALB listing on port number 80
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is from Backend ALB HTTP"
      status_code  = "200"
    }
  }
}