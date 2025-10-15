output "all_mws_workspaces" {
  value = data.databricks_mws_workspaces.all.ids
}

output "budget_policy" {
  description = "Budget Policy"
  value = {
    policy = {
      policy_name           = databricks_budget_policy.this.policy_name
      policy_id             = databricks_budget_policy.this.policy_id
      custom_tags           = databricks_budget_policy.this.custom_tags
      binding_workspace_ids = databricks_budget_policy.this.binding_workspace_ids
    }

    grants = {
      users = flatten([
        for rule in databricks_access_control_rule_set.this.grant_rules :
        rule.principals if rule.role == "roles/budgetPolicy.user"
      ])

      owners = flatten([
        for rule in databricks_access_control_rule_set.this.grant_rules :
        rule.principals if rule.role == "roles/budgetPolicy.manager"
      ])
    }
  }
}
