provider "aws" {
  region = var.aws_region
}

module "network" {
  source             = "./modules/network"
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "us-east-1a"
}

module "ec2_lb" {
  source            = "./modules/ec2-lb"
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.app_sg_id
  key_name          = var.key_name
}

module "ec2_app" {
  source            = "./modules/ec2-app"
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.app_sg_id
  key_name          = var.key_name
}