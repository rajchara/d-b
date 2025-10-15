################################################################################
# Databricks account settings
################################################################################

variable "databricks_account_id" {
  description = "The ID of the Databricks Account"
  type        = string
}

################################################################################
# Budget Policy Input
################################################################################

variable "name" {
  description = "(Mandatory) Display name for the budget policy"
  type        = string
}

variable "workspaces" {
  description = "(Mandatory) List of workspace names to apply the policy to. Note that this will be converted to id's"
  type        = list(string)

  validation {
    condition     = length(var.workspaces) > 0
    error_message = "At least one workspace name must be specified in the workspaces list."
  }
}

variable "tag_businessunit" {
  description = "(Mandatory) Business unit tag value"
  type        = string
}

variable "tag_domain" {
  description = "(Mandatory) Domain tag value"
  type        = string
}

variable "tag_costcode" {
  description = "(Mandatory) Cost code tag value"
  type        = string
}

variable "customtags" {
  description = "Additional custom tags as key-value pairs"
  type        = map(string)
  default     = {}
}

variable "owners" {
  description = "List of user/group IDs with owner permissions. Note will always append the core platform team."
  type        = list(string)
  default     = []
}

variable "users" {
  description = "List of user/group IDs with user permissions"
  type        = list(string)
  default     = []
}
