variable "db_identifier" {}
variable "engine" {}
variable "instance_class" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "security_group_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type    = map(string)
  default = {}
}