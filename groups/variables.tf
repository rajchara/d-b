################################################################################
# Groups Inputs
################################################################################

variable "group_name" {
  type        = string
  description = "Name of the group to create"
}

variable "users" {
  type        = set(string)
  description = "Set of users to assign to the group"
  default     = []
}

variable "service_principals" {
  type        = set(string)
  description = "Set of service principals to assign to the group"
  default     = []
}

variable "groups" {
  type        = set(string)
  description = "Set of groups to assign to the group"
  default     = []
}

variable "workspace_assignments" {
  type = list(object({
    workspace_name = string
    permissions    = list(string)
  }))
  description = "List of workspace assignments for this group"
  default     = []

  validation {
    condition = length(var.workspace_assignments) != 0 ? alltrue([
      for item in toset(flatten([for assignment in var.workspace_assignments : assignment.permissions])) : contains(["USER", "ADMIN"], item)
      if item != null
    ]) : true
    error_message = "Please provide either 'USER' or 'ADMIN' permission level for Account group on Workspace"
  }
}

variable "workspaces" {
  type = map(object({
    id = number
  }))
  description = "Map of workspace names to their IDs"
  default     = {}
}
