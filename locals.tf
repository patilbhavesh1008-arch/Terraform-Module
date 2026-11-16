locals {
  common_tags = {
    Project     = var.project_name
    Environment = "Lab"
    ManagedBy   = "Terraform"
    Owner       = "Bhavesh"
  }
}
