resource "azurerm_storage_blob_inventory_policy" "storage_blob_inventory_policys" {
  for_each = var.storage_blob_inventory_policys

  storage_account_id = each.value.storage_account_id

  rules {
    dynamic "filter" {
      for_each = each.value.rules.filter != null ? [each.value.rules.filter] : []
      content {
        blob_types            = filter.value.blob_types
        exclude_prefixes      = filter.value.exclude_prefixes
        include_blob_versions = filter.value.include_blob_versions
        include_deleted       = filter.value.include_deleted
        include_snapshots     = filter.value.include_snapshots
        prefix_match          = filter.value.prefix_match
      }
    }
    format                 = each.value.rules.format
    name                   = each.value.rules.name
    schedule               = each.value.rules.schedule
    schema_fields          = each.value.rules.schema_fields
    scope                  = each.value.rules.scope
    storage_container_name = each.value.rules.storage_container_name
  }
}

