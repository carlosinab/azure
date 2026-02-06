# Clone your repo and navigate to infrastructure folder
cd infrastructure

# Initialize Terraform
terraform init

# Plan
terraform plan -out=tfplan

# Apply
terraform apply tfplan