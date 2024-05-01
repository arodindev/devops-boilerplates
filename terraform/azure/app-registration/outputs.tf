output "sp_pass" {
  value = azuread_service_principal_password.eks_auth_sp_pass.value
  sensitive = true
}

output "app_pass" {
  value = azuread_application_password.eks_auth_app_pass.value
  sensitive = true
}

output "app_object_id" {
  value = azuread_application.eks_auth_app.object_id
}

output "app_app_id" {
  value = azuread_application.eks_auth_app.client_id
}

output "sp_object_id" {
  value = azuread_service_principal.eks_auth_sp.object_id
}

output "sp_app_id" {
  value = azuread_service_principal.eks_auth_sp.client_id
}

output "sp_pass_vault_entry" {
  value = azurerm_key_vault_secret.eks_auth_sp_pass_vault_entry.value
  sensitive = true
}