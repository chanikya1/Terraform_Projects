variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "SSH key name for EC2 login"
}