resource "azurerm_storage_blob_inventory_policy" "storage_blob_inventory_policies" {
  for_each = var.storage_blob_inventory_policies

  storage_account_id = each.value.storage_account_id

  dynamic "rules" {
    for_each = each.value.rules
    content {
      dynamic "filter" {
        for_each = rules.value.filter != null ? [rules.value.filter] : []
        content {
          blob_types            = filter.value.blob_types
          exclude_prefixes      = filter.value.exclude_prefixes
          include_blob_versions = filter.value.include_blob_versions
          include_deleted       = filter.value.include_deleted
          include_snapshots     = filter.value.include_snapshots
          prefix_match          = filter.value.prefix_match
        }
      }
      format                 = rules.value.format
      name                   = rules.value.name
      schedule               = rules.value.schedule
      schema_fields          = rules.value.schema_fields
      scope                  = rules.value.scope
      storage_container_name = rules.value.storage_container_name
    }
  }
}

