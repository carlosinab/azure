# === STEP 1: Login and set context ===
az login
az account set --subscription "139ed0b8-9ed0-4aeb-bfff-89cf33866e1c"
$tenantId = az account show --query tenantId -o tsv
Write-Host "Tenant ID: $tenantId"

# === STEP 2: Create Identity ===
$identityJson = az identity create --name "bg-hello-world-github-oidc" --resource-group "rg-azurelab-sysres" --location "switzerlandnorth" -o json
$identity = $identityJson | ConvertFrom-Json
$clientId = $identity.clientId
$principalId = $identity.principalId
Write-Host "Client ID: $clientId"

# === STEP 3: Grant permissions ===
az role assignment create --assignee $principalId --role "Owner" --scope "/subscriptions/139ed0b8-9ed0-4aeb-bfff-89cf33866e1c/resourceGroups/rg-azurelab-sysres"

# === STEP 4: Create federated credentials (replace YOUR_REPO) ===
$repo = "YOUR_USERNAME/YOUR_REPO_NAME"
az identity federated-credential create --name "github-main" --identity-name "bg-hello-world-github-oidc" --resource-group "rg-azurelab-sysres" --issuer "https://token.actions.githubusercontent.com" --subject "repo:$($repo):ref:refs/heads/main" --audiences '["api://AzureADTokenExchange"]'

# === STEP 5: Display secrets ===
Write-Host "`nAdd these to GitHub Secrets:"
Write-Host "AZURE_CLIENT_ID: $clientId"
Write-Host "AZURE_TENANT_ID: $tenantId"
Write-Host "AZURE_SUBSCRIPTION_ID: 139ed0b8-9ed0-4aeb-bfff-89cf33866e1c"