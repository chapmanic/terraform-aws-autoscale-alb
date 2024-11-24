# Creation of Application Load Balancer w/ SG and Subnet defined
resource "aws_lb" "ec2_alb" {
  name               = "ec2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_sg.id]
  subnets            = var.public_subnets_id
}

# Creation of Target group w/ VPC and Health check
resource "aws_lb_target_group" "ec2_alb" {
  name     = "ec2-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 15
    matcher             = "200"
  }
}

# Creation of LB listener on port 80
resource "aws_lb_listener" "ec2_alb" {
  load_balancer_arn = aws_lb.ec2_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_alb.arn
  }
}