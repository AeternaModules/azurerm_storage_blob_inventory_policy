output "storage_blob_inventory_policies_id" {
  description = "Map of id values across all storage_blob_inventory_policies, keyed the same as var.storage_blob_inventory_policies"
  value       = { for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "storage_blob_inventory_policies_rules" {
  description = "Map of rules values across all storage_blob_inventory_policies, keyed the same as var.storage_blob_inventory_policies"
  value       = { for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : k => v.rules if v.rules != null && length(v.rules) > 0 }
}
output "storage_blob_inventory_policies_storage_account_id" {
  description = "Map of storage_account_id values across all storage_blob_inventory_policies, keyed the same as var.storage_blob_inventory_policies"
  value       = { for k, v in azurerm_storage_blob_inventory_policy.storage_blob_inventory_policies : k => v.storage_account_id if v.storage_account_id != null && length(v.storage_account_id) > 0 }
}

