variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "139ed0b8-9ed0-4aeb-bfff-89cf33866e1c"
}

variable "tenant_id" {
  description = "Azure Tenant ID (from az account show)"
  type        = string
  default     = "7b5acc40-4d40-4147-9aa0-4f08d943d9ff"
}

variable "resource_group_name" {
  description = "Target Resource Group"
  type        = string
  default     = "rg-azurelab-sysres"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "switzerlandnorth"
}

variable "app_name" {
  description = "Base name for the web app"
  type        = string
  default     = "app-azurelab-sysres"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "sandbox"
}

# create with ..\scrpits\powershell\storage.ps1 script
variable "storage_account_name" {
  description = "Storage account name for terraform state (must be globally unique)"
  type        = string
  default     = "tfstazurelabsysres1493" 
}