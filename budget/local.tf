locals {
  workspace_name_to_id = {
    for ws in data.databricks_mws_workspaces.all.workspaces : ws.workspace_name => ws.workspace_id
  }

  central_team_owner_groups     = ["Lakehouse Databricks Account Console Admins"]
  users_groupname_to_principal  = [for group in data.databricks_group.users : group.acl_principal_id]
  owners_groupname_to_principal = [for group in data.databricks_group.owners : group.acl_principal_id]

}

data "databricks_mws_workspaces" "all" {
}

data "databricks_group" "users" {
  for_each     = toset(var.users)
  display_name = each.value
}

data "databricks_group" "owners" {
  for_each     = toset(distinct(concat(var.owners, local.central_team_owner_groups)))
  display_name = each.value
}
