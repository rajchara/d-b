variable "workspaces" {
  description = "List of workspace names to lookup"
  type        = list(string)
  default     = []
}

variable "cloud_provider" {
  description = "Cloud provider (aws or azure)"
  type        = string
  validation {
    condition     = contains(["aws", "azure"], var.cloud_provider)
    error_message = "Cloud provider must be either 'aws' or 'azure'."
  }
}



variable "budget_policies" {
  description = "Map of budget policies to create"
  type = map(object({
    name             = string
    workspaces       = list(string)
    tag_businessunit = string
    tag_domain       = string
    tag_costcode     = string
    customtags       = map(string)
    owners           = list(string)
    users            = list(string)
  }))
  default = {}
}

variable "workspace_group_assignment" {
  description = "Map of workspace names to admin and user group assignments"
  type = map(object({
    admin_groups = optional(list(string), [])
    user_groups  = optional(list(string), [])
  }))
  default = {}
}

variable "databricks_client_id" {
  description = "The OAuth username for a databricks service principal with admin permissions"
  type        = string
}

variable "databricks_client_secret" {
  description = "The OAuth password for a databricks service principal with admin permissions"
  type        = string
  sensitive   = true
}

variable "groups" {
  description = "Map of groups to create"
  type = map(object({
    users              = optional(set(string))
    service_principals = optional(set(string))
    groups             = optional(set(string))
  }))
  default = {}
}

variable "domain_prefix" {
  description = "Domain prefix for group names (e.g., rtlh_di)"
  type        = string
}

variable "environment" {
  description = "Environment suffix for group names (e.g., dev, tst, prd)"
  type        = string
}
