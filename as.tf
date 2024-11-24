# Creation of Launch template w/ UserData, AMI, KeyPair & SG
resource "aws_launch_template" "ec2_template" {
  name_prefix   = "ec2_instance_test"
  image_id      = var.webserver-ami
  instance_type = "t2.micro"
  #   user_data     = base64encode(file("user-data.sh"))
  key_name = "amc-default"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2-sg.id]
    device_index                = 0
  }
}

# Creation of AutoScaling Group w/ Subnet, TargetGroup & Template
resource "aws_autoscaling_group" "ec2_test_group" {
  name                = "ec2_testing_group"
  vpc_zone_identifier = var.private_subnets_id
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  launch_template {
    id = aws_launch_template.ec2_template.id
  }
  target_group_arns = [aws_lb_target_group.ec2_alb.arn]
}

# Creation of KeyPair using public key
resource "aws_key_pair" "amc-default" {
  key_name   = "amc-default"
  public_key = file("ec2_test.pub")
}
