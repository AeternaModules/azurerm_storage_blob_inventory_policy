variable "storage_blob_inventory_policies" {
  description = <<EOT
Map of storage_blob_inventory_policies, attributes below
Required:
    - storage_account_id
    - rules (block):
        - filter (optional, block):
            - blob_types (required)
            - exclude_prefixes (optional)
            - include_blob_versions (optional)
            - include_deleted (optional)
            - include_snapshots (optional)
            - prefix_match (optional)
        - format (required)
        - name (required)
        - schedule (required)
        - schema_fields (required)
        - scope (required)
        - storage_container_name (required)
EOT

  type = map(object({
    storage_account_id = string
    rules = list(object({
      filter = optional(object({
        blob_types            = set(string)
        exclude_prefixes      = optional(set(string))
        include_blob_versions = optional(bool)
        include_deleted       = optional(bool)
        include_snapshots     = optional(bool)
        prefix_match          = optional(set(string))
      }))
      format                 = string
      name                   = string
      schedule               = string
      schema_fields          = list(string)
      scope                  = string
      storage_container_name = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        length(v.rules) >= 1
      )
    ])
    error_message = "Each rules list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        alltrue([for item in v.rules : (length(item.name) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        alltrue([for item in v.rules : (alltrue([for x in item.schema_fields : length(x) > 0]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        alltrue([for item in v.rules : (item.filter == null || (alltrue([for x in item.filter.blob_types : contains(["blockBlob", "appendBlob", "pageBlob"], x)])))])
      )
    ])
    error_message = "must be one of: blockBlob, appendBlob, pageBlob"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        alltrue([for item in v.rules : (item.filter == null || (item.filter.prefix_match == null || (alltrue([for x in item.filter.prefix_match : length(x) > 0]))))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        alltrue([for item in v.rules : (item.filter == null || (item.filter.exclude_prefixes == null || (alltrue([for x in item.filter.exclude_prefixes : length(x) > 0]))))])
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 8 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

