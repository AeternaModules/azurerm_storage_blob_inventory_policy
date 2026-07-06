output "storage_blob_inventory_policies" {
  description = "All storage_blob_inventory_policy resources"
  value       = azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies
}
output "storage_blob_inventory_policies_rules" {
  description = "List of rules values across all storage_blob_inventory_policies"
  value       = [for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : v.rules]
}
output "storage_blob_inventory_policies_storage_account_id" {
  description = "List of storage_account_id values across all storage_blob_inventory_policies"
  value       = [for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : v.storage_account_id]
}

