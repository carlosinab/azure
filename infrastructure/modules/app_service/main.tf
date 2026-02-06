resource "azurerm_service_plan" "plan" {
  name                = "${var.app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1"  # Standard tier required for deployment slots
}

resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      # Using HTML/Static site via PHP or Node (simplest for static content)
      # Or we can use a simple PHP container
      php_version = "8.2"
    }
  }

  # Configure for blue/green with deployment slots
  logs {
    application_logs {
      file_system_level = "Information"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  tags = var.tags
}

# Staging slot for Blue/Green deployment
resource "azurerm_linux_web_app_slot" "staging" {
  name           = "staging"
  app_service_id = azurerm_linux_web_app.main.id

  site_config {
    application_stack {
      php_version = "8.2"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  tags = var.tags
}

# Slot swap resource (for Terraform-controlled swaps if needed)
resource "azurerm_web_app_active_slot" "swap" {
  slot_id = azurerm_linux_web_app_slot.staging.id
}

output "production_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "staging_url" {
  value = "https://${azurerm_linux_web_app_slot.staging.default_hostname}"
}

output "app_name" {
  value = azurerm_linux_web_app.main.name
}