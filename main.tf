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
  workspace_assignments = local.group_workspace_assignments[each.key]
  workspaces            = local.workspace_ids
}

module "budget_policies" {
  source     = "./budget-policies"
  for_each   = var.budget_policies
  depends_on = [module.groups]

  providers = {
    databricks = databricks.mws
  }

  databricks_account_id = var.cloud_provider == "aws" ? "782ba817-b9bf-4033-9aa9-56bb80139fba" : "fe1630db-b2af-4ac1-a394-9f0e33096a57"
  name                  = each.value.name
  workspaces            = each.value.workspaces
  tag_businessunit      = each.value.tag_businessunit
  tag_domain            = each.value.tag_domain
  tag_costcode          = each.value.tag_costcode
  customtags            = each.value.customtags
  owners                = each.value.owners
  users                 = each.value.users
}
