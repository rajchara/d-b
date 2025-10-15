# Databricks Account Configuration
databricks_account_id = "your-databricks-account-id"
workspace_id         = "your-workspace-id"

# Budget Policy Configuration
budget_policies = {
  "core-aws-budget" = {
    name             = "AWS Budget Policy"
    workspaces       = ["db-rtlh-di-aws-syd-dev"]
    tag_businessunit = "Core"
    tag_domain      = "AWS"
    tag_costcode    = "CC001"
    customtags = {
      environment = "dev"
      team       = "dataintegration"
    }
    owners = ["core-platform-team"]
    users  = ["harika.gouthreddy@riotinto.com"]
  }
}

# Workspace Group Assignment Configuration
workspace_group_assignments = {
  "core-admins" = {
    group_name  = "core-admins"
    permissions = ["ADMIN"]
  }
  "core-users" = {
    group_name  = "core-users"
    permissions = ["USER"]
  }
}
