# Creation of ALB SG
resource "aws_security_group" "allow_http_sg" {
  name   = "allow_http"
  vpc_id = var.vpc_id
  tags = {
    Name = "allow_http"
  }
}

# ALB SG inbound port 80 (HTTP)
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
# # ALB SG inbound port 443 (HTTPS)
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
# ALB SG inbound port 22 (SSH)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
# ALB SG Outbound Full Access 
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.allow_http_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ----------------------------------------------------------------------------------------------

# Creation of EC2 SG
resource "aws_security_group" "ec2-sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "ec2-sg"
  }
}
# ALB SG inbound access from ALB Security Group 80 (HTTP)
resource "aws_vpc_security_group_ingress_rule" "allow_http_alb" {
  security_group_id            = aws_security_group.ec2-sg.id
  referenced_security_group_id = aws_security_group.allow_http_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}
# ALB SG Outbound Full Access 
resource "aws_vpc_security_group_egress_rule" "allow_all_alb" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
