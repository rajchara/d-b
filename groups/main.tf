# Creates group in Databricks Account
resource "databricks_group" "this" {
  for_each = toset(compact(var.groups[*].name))

  display_name = each.key
  lifecycle { ignore_changes = [external_id, allow_cluster_create, allow_instance_pool_create, databricks_sql_access, workspace_access] }
}

# Adds Users, Service Principals, and Groups to associated Databricks Account group
resource "databricks_group_member" "this" {
  for_each = merge(local.users_map, local.service_principals_map, local.groups_map)

  group_id = databricks_group.this[each.value.name].id
  member_id = startswith(each.key, "user") ? data.databricks_user.this[each.key].id : (
    startswith(each.key, "sp") ? data.databricks_service_principal.this[each.key].id :
    data.databricks_group.member_groups[each.key].id
  )
}

# Assigning Databricks Account group to Databricks Workspace
resource "databricks_mws_permission_assignment" "this" {
  for_each = {
    for group in var.workspace_group_assignment : group.group_name => group
    if group.group_name != null
  }

  workspace_id = var.workspace_id
  principal_id = data.databricks_group.this[each.key].id
  permissions  = each.value.permissions

  lifecycle {
    ignore_changes = [principal_id]
  }
}
