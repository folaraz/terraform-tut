output "instance_id" {
  description = "EC2 instance ID"
  value = aws_instance.app_server.id
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
  description = "Public IP addresses for EC2 Instance"
}