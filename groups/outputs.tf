output "databricks_group" {
  description = "Created Databricks account-level group"
  value       = databricks_group.this
}

output "databricks_group_member_users" {
  description = "User assignments to group"
  value       = databricks_group_member.users
}

output "databricks_group_member_service_principals" {
  description = "Service principal assignments to group"
  value       = databricks_group_member.service_principals
}

output "databricks_group_member_groups" {
  description = "Group assignments to group"
  value       = databricks_group_member.groups
}

output "databricks_mws_permission_assignment" {
  description = "Group assignments to workspaces"
  value       = databricks_mws_permission_assignment.this
}

output "group_id" {
  description = "Group ID"
  value       = databricks_group.this.id
}
