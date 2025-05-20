output "public_ip" {
  value = aws_instance.nginx_lb.public_ip
}