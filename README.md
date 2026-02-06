# Azure Blue/Green Deployment Project

This project demonstrates how to set up a blue/green deployment strategy for a static website hosted on Azure using Terraform and GitHub Actions. The project is structured to allow easy testing and switching between two versions of the website.

## Project Structure

```
azure-bluegreen/
├── .github/
│   └── workflows/
│       └── bluegreen-deploy.yml    # GitHub Actions pipeline
├── infrastructure/
│   ├── modules/
│   │   ├── app_service/            # App Service with slots module
│   │   └── identity/               # Managed Identity module
│   ├── main.tf
│   ├── variables.tf
│   ├── providers.tf
│   └── backend.tf                  # (Optional) Terraform state backend
├── app/
│   ├── index.html                  # Version 1 (Blue)
│   └── index-v2.html               # Version 2 (Green)
└── scripts/
```

## Setup Instructions

1. **Clone the Repository**
   Clone this repository to your local machine.

   ```
   git clone <repository-url>
   cd azure-bluegreen-deployment
   ```

2. **Configure Terraform**
   Update the `terraform/terraform.tfvars` file with your Azure credentials and desired resource names.

3. **Initialize Terraform**
   Navigate to the `terraform` directory and run the following command to initialize Terraform:

   ```
   terraform init
   ```

4. **Apply Terraform Configuration**
   Run the following command to apply the Terraform configuration and create the necessary Azure resources:

   ```
   terraform apply
   ```

5. **Deploy the Application**
   The GitHub Actions workflow defined in `.github/workflows/deploy.yml` will automatically deploy the application to Azure whenever changes are pushed to the main branch.

## Blue/Green Deployment Strategy

This project utilizes Azure deployment slots to implement a blue/green deployment strategy. The two versions of the website (v1 and v2) are deployed to separate slots, allowing for seamless switching between them. This minimizes downtime and provides a safe way to test new versions before making them live.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.