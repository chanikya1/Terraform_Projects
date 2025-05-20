resource "aws_instance" "nginx_lb" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = file("lb-user-data.sh")

  tags = {
    Name = "nginx-lb"
  }
}