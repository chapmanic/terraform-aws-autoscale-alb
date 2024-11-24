# Terraform (IaC)

AWS Terraform (IaC) code which creates a webserver autoscaling group, served behind an Application Load Balancer.
Ec2 instances are configured to run within private subnets. Security groups designed to allow controlled access.

## Features

- AWS Security group creation
- AWS Application Load Balancer and Autoscaling creation
- Custom AMI used with pre-configured web server and basic web page (user-data for reference)