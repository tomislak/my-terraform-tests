provider "aws" {
  profile = "default"
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  count = var.instance_count

  ami             = var.resource_ami_amazonLinux2
  instance_type   = "t2.micro"
  key_name        = "etokral@ubuntu2004gui"
  security_groups = ["my-default", ]

  tags = {
    Name	= var.app_server_instance_name
    Project     = var.project
    Environment = var.environment
  }
}

