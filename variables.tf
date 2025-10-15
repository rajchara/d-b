variable "databricks_account_id" {
  description = "The ID of the Databricks Account"
  type        = string
}

variable "workspace_id" {
  description = "The ID of the Databricks Workspace"
  type        = string
}

variable "budget_policies" {
  description = "Map of budget policies to create"
  type = map(object({
    name             = string
    workspaces       = list(string)
    tag_businessunit = string
    tag_domain      = string
    tag_costcode    = string
    customtags      = map(string)
    owners          = list(string)
    users           = list(string)
  }))
  default = {}
}

variable "workspace_group_assignments" {
  description = "Map of workspace group assignments"
  type = map(object({
    group_name  = string
    permissions = list(string)
  }))
  default = {}
}
