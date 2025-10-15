locals {
  # Creates maps of objects where key is in form like "user:<group_name>:<user_name>" and value is objects of two parameters,
  # first element is a group name and second is user name
  users_map = {
    for object in flatten([
      for group in var.groups : [
        for pair in setproduct([group.name], group.users) : {
          name = pair[0], user = pair[1]
      }] if alltrue([group.name != null, group.users != null])
    ]) : "user:${object.name}:${object.user}" => object
  }

  # Creates maps of objects where key is in form like "sp:<group_name>:<user_name>" and value is object of two parameters,
  # first element is a group name and second is service principal name
  service_principals_map = {
    for object in flatten([
      for group in var.groups : [
        for pair in setproduct([group.name], group.service_principals) : {
          name = pair[0], service_principal = pair[1]
      }] if alltrue([group.name != null, group.service_principals != null])
    ]) : "sp:${object.name}:${object.service_principal}" => object
  }

  # Creates maps of objects where key is in form like "group:<group_name>:<member_group_name>" and value is object of two parameters,
  # first element is a group name and second is member group name
  groups_map = {
    for object in flatten([
      for group in var.groups : [
        for pair in setproduct([group.name], group.groups) : {
          name = pair[0], member_group = pair[1]
      }] if alltrue([group.name != null, group.groups != null])
    ]) : "group:${object.name}:${object.member_group}" => object
  }
}

# Reference to already existing User in Databricks Account
data "databricks_user" "this" {
  for_each  = local.users_map
  user_name = each.value.user
}

# Reference to already existing Service Principal in Databricks Account
data "databricks_service_principal" "this" {
  for_each       = local.service_principals_map
  application_id = each.value.service_principal
}

# References already existing or newly created groups in Databricks Account.
data "databricks_group" "this" {
  for_each     = toset(compact(var.workspace_group_assignment[*].group_name))
  display_name = each.value
  depends_on   = [databricks_group.this]
}

# Reference to existing groups that will be added as members to other groups
data "databricks_group" "member_groups" {
  for_each     = local.groups_map
  display_name = each.value.member_group
}
