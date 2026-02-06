resource "azurerm_user_assigned_identity" "github_oidc" {
  name                = "${var.app_name}-github-oidc"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

# Grant the identity Owner on the resource group (for Terraform deployments)
resource "azurerm_role_assignment" "rg_owner" {
  scope                = var.resource_group_id
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.github_oidc.principal_id
}

# Output the client ID for GitHub Actions
output "client_id" {
  value = azurerm_user_assigned_identity.github_oidc.client_id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.github_oidc.principal_id
}