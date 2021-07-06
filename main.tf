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
    Name        = var.app_server_instance_name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_instance" "pg_db_server" {
  ami             = var.resource_ami_amazonLinux2
  instance_type   = "t2.micro"
  key_name        = "etokral@ubuntu2004gui"
  security_groups = ["my-default", ]

  tags = {
    Name        = var.pg_db_server_instance_name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_instance" "proxy_server" {
  ami             = var.resource_ami_amazonLinux2
  instance_type   = "t2.micro"
  key_name        = "etokral@ubuntu2004gui"
  security_groups = ["my-default", ]

  tags = {
    Name        = var.proxy_server_instance_name
    Project     = var.project
    Environment = var.environment
  }
}

resource "local_file" "load_balancer_conf" {
  filename = "./ansible/files/load-balancer.tf.conf"
  content  = <<-EOT
    upstream backend {
    %{for ip in aws_instance.app_server.*.private_ip~}
      server ${ip};
    %{endfor~}
      }

      server {
        listen 80;
        location /hostDate {
          proxy_pass http://backend/cgi-bin/hostDate.py;
        }
      }
  EOT
}

resource "local_file" "database_ini" {
  filename = "./ansible/files/database.ini"
  content  = <<-EOT
    [postgresql]
    host=${aws_instance.pg_db_server.private_ip}
    database=hostDate
    user=hostDate
    password=hostDate
  EOT
}
