# Reference to already existing User in Databricks Account
data "databricks_user" "this" {
  provider  = databricks
  for_each  = var.users
  user_name = each.key
}

# Reference to already existing Service Principal in Databricks Account
data "databricks_service_principal" "this" {
  provider       = databricks
  for_each       = var.service_principals
  application_id = each.key
}

# Reference to existing groups that will be added as members to other groups
data "databricks_group" "member_groups" {
  provider     = databricks
  for_each     = var.groups
  display_name = each.key
}
