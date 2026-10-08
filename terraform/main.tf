terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws"{
    region = var.aws_region
}
resource "aws_ecr_repository" "employee_app"{
    name = "employee-management-app" 
    tags = {
    Environment = "Dev" 
}      
}
resource "aws_instance" "employee_server" {
     ami           = "ami-066c4849e6b3a1e3d"
  instance_type = var.instance_type
  vpc_security_group_ids = ["sg-09c628d7e0b546cd7"]
  subnet_id = "subnet-089735b06672b2a56"
  iam_instance_profile = "EC2-SSM-Role"
  key_name = "mywebkey-key"
  associate_public_ip_address = true

  tags = {
    Name = "mywebserver"
    Environment = "Dev"
  }
  
user_data_replace_on_change = false
user_data = <<-EOF
#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<html><h1>Welcome to Apache Web Server on Amazon Linux</h1></html>">
/var/www/html/index.html
EOF

root_block_device {
  volume_size           = 8
  volume_type           = "gp3"
  delete_on_termination = true
}
}