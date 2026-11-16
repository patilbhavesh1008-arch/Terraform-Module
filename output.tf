output "vpc_id" {
  description = "Created VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc.public_subnet_id
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.vpc.security_group_id
}

output "ec2_instance_id" {
  description = "BRAVE EC2 instance ID"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "BRAVE EC2 public IP"
  value       = module.ec2.public_ip
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}
