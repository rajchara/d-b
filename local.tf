locals {
  # Group definitions
  groups = {
    "core-admins" = {
      name               = "core-admins"
      users              = ["admin1@company.com", "admin2@company.com"]
      service_principals = ["sp-core-admin"]
      groups             = []
    }
    "core-users" = {
      name               = "core-users"
      users              = ["user1@company.com", "user2@company.com"]
      service_principals = []
      groups             = []
    }
    "aws-core-users" = {
      name               = "aws-core-users"
      users              = ["awsuser1@company.com", "awsuser2@company.com"]
      service_principals = ["sp-aws-core"]
      groups             = []
    }
  }

  # Convert groups map to list for module input
  groups_list = [for group in local.groups : group]

  # Workspace group assignments
  workspace_assignments = [
    for assignment_key, assignment in var.workspace_group_assignments : {
      group_name  = assignment.group_name
      permissions = assignment.permissions
    }
  ]
}
