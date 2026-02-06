# Variables
$resourceGroup = "rg-azurelab-sysres"
$location = "switzerlandnorth"
$storageAccountName = "tfstazurelabsysres$(Get-Random -Minimum 1000 -Maximum 9999)"  # Must be globally unique
$containerName = "tfstate"

# Create storage account
az storage account create `
    --name $storageAccountName `
    --resource-group $resourceGroup `
    --location $location `
    --sku "Standard_LRS" `
    --kind "StorageV2" `
    --allow-blob-public-access false `
    --min-tls-version "TLS1_2"

# Get storage key
$storageKey = az storage account keys list `
    --account-name $storageAccountName `
    --resource-group $resourceGroup `
    --query "[0].value" -o tsv

# Create container
az storage container create `
    --name $containerName `
    --account-name $storageAccountName `
    --account-key $storageKey

# Output for Terraform
Write-Host "`n=== Add this to your backend.tf ===" -ForegroundColor Green
Write-Host "storage_account_name: $storageAccountName"
Write-Host "container_name: $containerName"
Write-Host "key: `"terraform.tfstate`""
Write-Host "access_key: $storageKey"