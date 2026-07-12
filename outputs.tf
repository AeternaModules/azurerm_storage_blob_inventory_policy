output "storage_blob_inventory_policies_rules" {
  description = "Map of rules values across all storage_blob_inventory_policies, keyed the same as var.storage_blob_inventory_policies"
  value       = { for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : k => v.rules }
}
output "storage_blob_inventory_policies_storage_account_id" {
  description = "Map of storage_account_id values across all storage_blob_inventory_policies, keyed the same as var.storage_blob_inventory_policies"
  value       = { for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : k => v.storage_account_id }
}

