module "groups" {
  source = "./groups"
  
  groups                     = local.groups_list
  workspace_group_assignment = local.workspace_assignments
  workspace_id              = var.workspace_id
}

module "budget_policies" {
  source   = "./budget-policies"
  for_each = var.budget_policies

  databricks_account_id = var.databricks_account_id
  name                 = each.value.name
  workspaces           = each.value.workspaces
  tag_businessunit     = each.value.tag_businessunit
  tag_domain          = each.value.tag_domain
  tag_costcode        = each.value.tag_costcode
  customtags          = each.value.customtags
  owners              = each.value.owners
  users               = each.value.users
}
