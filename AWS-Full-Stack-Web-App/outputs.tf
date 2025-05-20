output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "rds_endpoint" {
  value = module.rds.endpoint
}