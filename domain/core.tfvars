# Databricks Account Configuration
databricks_account_id    = "782ba817-b9bf-4033-9aa9-56bb80139fba"
databricks_workspace_url = "https://accounts.cloud.databricks.com"
domain_prefix            = "rtlh_di"
environment              = "dev"

workspaces = {
  "db-rtlh-di-aws-syd-dev" = {
    id = 1510274096129198
  }
  "db-rtlh-di-aws-syd-tst" = {
    id = 585801573007897
  }
}

# Budget Policy Configuration
budget_policies = {
  "core-aws-budget" = {
    name             = "AWS Budget Policy"
    workspaces       = ["db-rtlh-di-aws-syd-dev", "db-rtlh-di-aws-syd-tst"]
    tag_businessunit = "core"
    tag_domain       = "aws"
    tag_costcode     = "P-1101088.02.10"
    customtags = {
      environment = "dev"
      team        = "DataIntegration"
    }
    owners = []
    users  = ["rtlh_di_analyst_dev"] # Use full group name
  }
}

groups = {
  "owner" = {
    users              = []
    service_principals = []
    groups             = []
  }
  "analyst" = {
    users              = ["harika.gouthreddy@riotinto.com"]
    service_principals = []
    groups             = []
  }
  "engineer" = {
    users              = []
    service_principals = []
    groups             = []
  }
}

# Workspace Group Assignment Configuration
workspace_group_assignment = {
  "owner" = [
    {
      workspace_name = "db-rtlh-di-aws-syd-dev"
      permissions    = ["ADMIN"]
    },
    {
      workspace_name = "db-rtlh-di-aws-syd-tst"
      permissions    = ["ADMIN"]
    }
  ]
  "analyst" = [
    {
      workspace_name = "db-rtlh-di-aws-syd-dev"
      permissions    = ["USER"]
    },
    {
      workspace_name = "db-rtlh-di-aws-syd-tst"
      permissions    = ["USER"]
    }
  ]
  "engineer" = [
    {
      workspace_name = "db-rtlh-di-aws-syd-dev"
      permissions    = ["USER"]
    },
    {
      workspace_name = "db-rtlh-di-aws-syd-tst"
      permissions    = ["USER"]
    }
  ]
}
