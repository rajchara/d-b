# Creates group in Databricks Account
resource "databricks_group" "this" {
  display_name = var.group_name
  lifecycle { ignore_changes = [external_id, allow_cluster_create, allow_instance_pool_create, databricks_sql_access, workspace_access] }
}

# Adds Users to the Databricks Account group
resource "databricks_group_member" "users" {
  for_each = var.users

  group_id  = databricks_group.this.id
  member_id = data.databricks_user.this[each.key].id
}

# Adds Service Principals to the Databricks Account group
resource "databricks_group_member" "service_principals" {
  for_each = var.service_principals

  group_id  = databricks_group.this.id
  member_id = data.databricks_service_principal.this[each.key].id
}

# Adds Groups to the Databricks Account group
resource "databricks_group_member" "groups" {
  for_each = var.groups

  group_id  = databricks_group.this.id
  member_id = data.databricks_group.member_groups[each.key].id
}

# Assigning Databricks Account group to Databricks Workspace
resource "databricks_mws_permission_assignment" "this" {
  for_each = {
    for idx, assignment in var.workspace_assignments : idx => assignment
  }

  workspace_id = var.workspaces[each.value.workspace_name].id
  principal_id = databricks_group.this.id
  permissions  = each.value.permissions

  lifecycle {
    ignore_changes = [principal_id]
  }
}
