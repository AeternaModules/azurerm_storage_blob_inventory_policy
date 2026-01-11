variable "storage_blob_inventory_policys" {
  description = <<EOT
Map of storage_blob_inventory_policys, attributes below
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
    rules = object({
      filter = optional(object({
        blob_types            = set(string)
        exclude_prefixes      = optional(set(string))
        include_blob_versions = optional(bool, false)
        include_deleted       = optional(bool, false)
        include_snapshots     = optional(bool, false)
        prefix_match          = optional(set(string))
      }))
      format                 = string
      name                   = string
      schedule               = string
      schema_fields          = list(string)
      scope                  = string
      storage_container_name = string
    })
  }))
}

