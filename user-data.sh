#!/bin/bash

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

echo "<h1>Instance: $(hostname -f)</h1>" | sudo tee /var/www/html/index.html