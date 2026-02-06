# Clone your repo and navigate to infrastructure folder
cd infrastructure

# Initialize Terraform
terraform init

#terraform fmt -check
#terraform validate

# Plan
terraform plan -out=tfplan

# Apply
terraform apply tfplan