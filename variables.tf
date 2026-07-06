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
    rules = object({
      filter = optional(object({
        blob_types            = set(string)
        exclude_prefixes      = optional(set(string))
        include_blob_versions = optional(bool) # Default: false
        include_deleted       = optional(bool) # Default: false
        include_snapshots     = optional(bool) # Default: false
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
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        length(v.rules.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        length(v.rules.schema_fields) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_blob_inventory_policies : (
        v.rules.filter == null || (contains(["blockBlob", "appendBlob", "pageBlob"], v.rules.filter.blob_types))
      )
    ])
    error_message = "must be one of: blockBlob, appendBlob, pageBlob"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_storage_blob_inventory_policy's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: rules.storage_container_name
  #   source:    [from validate.StorageContainerName] !regexp.MustCompile(`^\$root$|^\$web$|^[0-9a-z-]+$`).MatchString(value)
  # path: rules.storage_container_name
  #   source:    [from validate.StorageContainerName] len(value) < 3 || len(value) > 63
  # path: rules.storage_container_name
  #   source:    [from validate.StorageContainerName] regexp.MustCompile(`^-`).MatchString(value)
  # path: rules.format
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: rules.schedule
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: rules.scope
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: rules.filter.prefix_match[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: rules.filter.exclude_prefixes[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
}

