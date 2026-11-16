variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "ssh_allowed_cidr" {
  type = string
}

variable "ssh_port" {
  type = number
}

variable "http_port" {
  type = number
}

variable "ec2_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_owner" {
  type = string
}

variable "ami_name_filter" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_force_destroy" {
  type = bool
}
