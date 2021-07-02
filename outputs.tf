output "instance_app_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.*.id
}

output "instance_app_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.*.public_ip
}

output "instance_app_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.app_server.*.private_ip
}

output "instance_db_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.pg_db_server.*.id
}

output "instance_db_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.pg_db_server.*.public_ip
}

output "instance_db_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.pg_db_server.*.private_ip
}

output "instance_proxy_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.proxy_server.*.id
}

output "instance_proxy_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.proxy_server.*.public_ip
}

output "instance_proxy_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.proxy_server.*.private_ip
}
