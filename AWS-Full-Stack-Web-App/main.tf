provider "aws" {
  region = var.aws_region
}

module "network" {
  source             = "./modules/network"
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "us-east-1a"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "myapp-static-assets-bucket"
}

module "rds" {
  source            = "./modules/rds"
  db_identifier     = "myapp-db"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  db_name           = "appdb"
  db_username       = "admin"
  db_password       = "StrongPass123!"
  security_group_id = module.network.ec2_sg_id
  subnet_ids        = [module.network.public_subnet_id] # Or use dedicated private subnets
  tags = {
    environment = "dev"
    project     = "fullstack-app"
  }
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.micro"
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.ec2_sg_id
  key_name          = var.key_name
}