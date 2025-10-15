output "databricks_group" {
  description = "Map of created Databricks account-level groups"
  value       = databricks_group.this
}

output "databricks_group_member" {
  description = "Map of user and service principal assignments to groups"
  value       = databricks_group_member.this
}

output "databricks_mws_permission_assignment" {
  description = "Map of group assignments to workspaces"
  value       = databricks_mws_permission_assignment.this
}

output "group_ids" {
  description = "Map of group names to their IDs"
  value = {
    for k, v in databricks_group.this : k => v.id
  }
}
