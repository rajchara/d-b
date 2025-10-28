variable "databricks_account_id" {
  description = "The ID of the Databricks Account"
  type        = string
}

variable "workspaces" {
  description = "Map of workspace names to their IDs"
  type = map(object({
    id = number
  }))
  default = {}
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
  description = "Map of group names to their workspace assignments"
  type = map(list(object({
    workspace_name = string
    permissions    = list(string)
  })))
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

variable "databricks_workspace_url" {
  description = "The URL of the Databricks workspace"
  type        = string
}

variable "domain_prefix" {
  description = "Domain prefix for group names (e.g., rtlh_di)"
  type        = string
}

variable "environment" {
  description = "Environment suffix for group names (e.g., dev, tst, prd)"
  type        = string
}
