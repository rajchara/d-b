resource "databricks_budget_policy" "this" {
  policy_name           = var.name
  binding_workspace_ids = [for ws_name in var.workspaces : local.workspace_name_to_id[ws_name]]
  custom_tags = [for k, v in merge({
    businessunit = var.tag_businessunit
    domain       = var.tag_domain
    costcode     = var.tag_costcode
    }, var.customtags) : {
    key   = k
    value = v
  }]
}

# ref: https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/access_control_rule_set#budget-policy-usage
resource "databricks_access_control_rule_set" "this" {
  name = "accounts/${var.databricks_account_id}/budgetPolicies/${databricks_budget_policy.this.policy_id}/ruleSets/default"

  // Core platform team owns as well as merging in owners list
  grant_rules {
    principals = local.owners_groupname_to_principal
    role       = "roles/budgetPolicy.manager"
  }
  // Each domain group is a user
  grant_rules {
    principals = local.users_groupname_to_principal
    role       = "roles/budgetPolicy.user"
  }
}
