# good practice to have these in one place
locals {
  app_owners = [
    data.azuread_client_config.current.object_id,
    data.azuread_user.owner.object_id
  ]
}

data "azurerm_client_config" "current" {}

# resource group
resource "azurerm_resource_group" "eks_auth_rg" {
  name = "eks-auth-rg"
  location = "West Europe"
}

# key vault
resource "azurerm_key_vault" "eks_auth_kv" {
  name = "eks-auth-kv"
  location = azurerm_resource_group.eks_auth_rg.location
  resource_group_name = azurerm_resource_group.eks_auth_rg.name
  enabled_for_disk_encryption = true
  tenant_id = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Delete"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover",
      "Restore"
    ]
  }
}

data "azuread_client_config" "current" {}

# app registration
resource "azuread_application" "eks_auth_app" {
  display_name = "eks-auth"
  owners = local.app_owners
}

resource "azuread_application_password" "eks_auth_app_pass" {
  display_name = "eks-auth-app-pass"
  application_id = azuread_application.eks_auth_app.id
}

# enterprise app (service principal)
resource "azuread_service_principal" "eks_auth_sp" {
  client_id = azuread_application.eks_auth_app.client_id
  app_role_assignment_required = false
  owners = local.app_owners
}

resource "azuread_service_principal_password" "eks_auth_sp_pass" {
  #display_name = "eks-auth-sp-pass"
  service_principal_id = azuread_service_principal.eks_auth_sp.object_id
}

data azuread_user "owner" {
    user_principal_name = var.owner_username
}

# vault entry
resource "azurerm_key_vault_secret" "eks_auth_sp_pass_vault_entry" {
  name = "eks-auth-sp-pass"
  value = azuread_service_principal_password.eks_auth_sp_pass.value
  key_vault_id = azurerm_key_vault.eks_auth_kv.id
}
