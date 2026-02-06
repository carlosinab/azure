# 1. Login to Azure
az login
# az login --tenant "loterie.onmicrosoft.com" --use-device

# 2. Set context to your subscription
az account set --subscription "139ed0b8-9ed0-4aeb-bfff-89cf33866e1c"

# 3. Get your Tenant ID
az account show --query tenantId -o tsv

# 4. Create User Assigned Managed Identity in your RG
az identity create \
  --name "app-azurelab-sysres-github-oidc" \
  --resource-group "rg-azurelab-sysres" \
  --location "switzerlandnorth"

# 5. Get the Client ID and Principal ID
export USER_IDENTITY_CLIENT_ID=$(az identity show \
  --name "app-azurelab-sysres-github-oidc" \
  --resource-group "rg-azurelab-sysres" \
  --query clientId -o tsv)

export USER_IDENTITY_PRINCIPAL_ID=$(az identity show \
  --name "app-azurelab-sysres-github-oidc" \
  --resource-group "rg-azurelab-sysres" \
  --query principalId -o tsv)

# 6. Grant Owner role on the Resource Group to the Managed Identity
az role assignment create \
  --assignee $USER_IDENTITY_PRINCIPAL_ID \
  --role "Owner" \
  --scope "/subscriptions/139ed0b8-9ed0-4aeb-bfff-89cf33866e1c/resourceGroups/rg-azurelab-sysres"

# 7. Create Federated Credential for GitHub Actions (main branch)
az identity federated-credential create \
  --name "github-main" \
  --identity-name "bg-hello-world-github-oidc" \
  --resource-group "rg-azurelab-sysres" \
  --issuer "https://token.actions.githubusercontent.com" \
  --subject "repo:YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:ref:refs/heads/main" \
  --audiences "api://AzureADTokenExchange"

# 8. Create Federated Credential for environment branches
az identity federated-credential create \
  --name "github-v1" \
  --identity-name "bg-hello-world-github-oidc" \
  --resource-group "rg-azurelab-sysres" \
  --issuer "https://token.actions.githubusercontent.com" \
  --subject "repo:YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:ref:refs/heads/v1" \
  --audiences "api://AzureADTokenExchange"

az identity federated-credential create \
  --name "github-v2" \
  --identity-name "bg-hello-world-github-oidc" \
  --resource-group "rg-azurelab-sysres" \
  --issuer "https://token.actions.githubusercontent.com" \
  --subject "repo:YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:ref:refs/heads/v2" \
  --audiences "api://AzureADTokenExchange"