resource "aws_instance" "app" {
  count                       = 2
  ami                         = "ami-0c55b19cfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  key_name                    = var.key_name

  tags = {
    Name = "app-server-${count.index + 1}"
  }
}