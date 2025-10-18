# Databricks Account Configuration
databricks_account_id = "782ba817-b9bf-4033-9aa9-56bb80139fba"
workspace_id         = "1510274096129198"

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
    owners = []
    users  = []
  }
}

# Workspace Group Assignment Configuration
workspace_group_assignments = {
  "db-rtlh-di-aws-syd-dev-owner" = {
    group_name  = "db-rtlh-di-aws-syd-dev-owner"
    permissions = ["ADMIN"]
  }
  "db-rtlh-di-aws-syd-dev-analyst" = {
    group_name  = "db-rtlh-di-aws-syd-dev-analyst"
    permissions = ["USER"]
  }
  "db-rtlh-di-aws-syd-dev-engineer" = {
    group_name  = "db-rtlh-di-aws-syd-dev-engineer"
    permissions = ["USER"]
  }
}
