# Data source for all Databricks workspaces
data "databricks_mws_workspaces" "all" {
  provider = databricks.mws
}

locals {
  # Construct full group names for budget policies
  full_group_names = {
    for persona, config in var.groups : persona => "${var.domain_prefix}_${persona}_${var.environment}"
  }

  # Create workspace map with IDs from MWS data source
  workspace_ids = {
    for workspace_name in var.workspaces : workspace_name => {
      id = data.databricks_mws_workspaces.all.ids[workspace_name]
    }
  }

  # Create workspace assignments for each group
  group_workspace_assignments = {
    for group_key, group_config in var.groups : group_key => [
      for workspace_name, workspace_config in var.workspace_group_assignment : {
        workspace_name = workspace_name
        permissions = contains(workspace_config.admin_groups, group_key) ? ["ADMIN"] : (
          contains(workspace_config.user_groups, group_key) ? ["USER"] : []
        )
      } if contains(workspace_config.admin_groups, group_key) || contains(workspace_config.user_groups, group_key)
    ]
  }
}
