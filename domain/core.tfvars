# Databricks Account Configuration
domain_prefix  = "rtlh_di"
environment    = "dev"
cloud_provider = "aws"

workspaces = ["db-rtlh-di-aws-syd-dev", "db-rtlh-di-aws-syd-tst"]

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
    users              = ["user@riotinto.com"]
    service_principals = []
    groups             = []
  }
  "analyst" = {
    users              = ["user@riotinto.com"]
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
  "db-rtlh-di-aws-syd-dev" = {
    admin_groups = ["owner"]
    user_groups  = ["analyst", "engineer"]
  }
  "db-rtlh-di-aws-syd-tst" = {
    admin_groups = ["owner"]
    user_groups  = ["analyst", "engineer"]
  }
}



####### azure tfvars #####
# Databricks Account Configuration
domain_prefix  = "rtlh_di"
environment    = "dev"
cloud_provider = "azure"

workspaces = ["db-rtlh-di-az-syd-dev"]

# Budget Policy Configuration
budget_policies = {
  "core-az-budget" = {
    name             = "Azure Budget Policy"
    workspaces       = ["db-rtlh-di-az-syd-dev"]
    tag_businessunit = "core"
    tag_domain       = "azure"
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
    users              = ["user@riotinto.com"]
    service_principals = []
    groups             = []
  }
  "analyst" = {
    users              = ["user@riotinto.com"]
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
  "db-rtlh-di-az-syd-dev" = {
    admin_groups = ["owner"]
    user_groups  = ["analyst", "engineer"]
  }
}
