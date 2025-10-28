locals {
  # Construct full group names for budget policies
  full_group_names = {
    for persona, config in var.groups : persona => "${var.domain_prefix}_${persona}_${var.environment}"
  }
}

module "groups" {
  source   = "./groups"
  for_each = var.groups

  providers = {
    databricks = databricks.mws
  }

  group_name            = "${var.domain_prefix}_${each.key}_${var.environment}"
  users                 = each.value.users != null ? each.value.users : []
  service_principals    = each.value.service_principals != null ? each.value.service_principals : []
  groups                = each.value.groups != null ? each.value.groups : []
  workspace_assignments = lookup(var.workspace_group_assignment, each.key, [])
  workspaces           = var.workspaces
}

module "budget_policies" {
  source     = "./budget-policies"
  for_each   = var.budget_policies
  depends_on = [module.groups]

  providers = {
    databricks = databricks.mws
  }

  databricks_account_id = var.databricks_account_id
  name                  = each.value.name
  workspaces            = each.value.workspaces
  tag_businessunit      = each.value.tag_businessunit
  tag_domain            = each.value.tag_domain
  tag_costcode          = each.value.tag_costcode
  customtags            = each.value.customtags
  owners                = each.value.owners
  users                 = each.value.users
}
