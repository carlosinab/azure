locals {
  tags = {
    Environment = var.environment
    Purpose     = "BlueGreen-Testing"
    ManagedBy   = "Terraform"
    Owner       = "Sysres"
  }
}