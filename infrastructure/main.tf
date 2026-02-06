# data "azurerm_resource_group" "target" {
#   name = var.resource_group_name
#}

module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
}

# on Entra ID permission assignment to the User Assigned Managed Identity
#module "identity" {
#  source = "./modules/identity"
#
#  app_name            = var.app_name
#  resource_group_name = var.resource_group_name
#  resource_group_id   = module.resource_group.main_id
#  location            = var.location
#  tags                = local.tags
#}

module "app_service" {
  source = "./modules/app_service"

  app_name            = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags
}