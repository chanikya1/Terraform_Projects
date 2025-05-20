resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "main-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone
  tags = { Name = "public-subnet" }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "ec2_sg" {
    name = "ec2-sg"
    description = "Allow SSH, HTTP"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}



