module "vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  subnet_name         = var.subnet_name
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
  igw_name            = var.igw_name
  route_table_name    = var.route_table_name
  security_group_name = var.security_group_name
  ssh_allowed_cidr    = var.ssh_allowed_cidr
  ssh_port            = var.ssh_port
  http_port           = var.http_port
}

module "ec2" {
  source = "./modules/ec2-instances"

  ec2_name          = var.ec2_name
  instance_type     = var.instance_type
  ami_id            = data.aws_ami.amazon_linux.id
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
}

module "s3" {
  source = "./modules/s3-bucket"

  bucket_name   = var.bucket_name
  force_destroy = var.bucket_force_destroy
}
