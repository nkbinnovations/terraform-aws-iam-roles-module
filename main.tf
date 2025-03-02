# Description: This file contains the terraform code to create IAM roles and policies

# Define the IAM Policies
resource "aws_iam_policy" "policy" {
  for_each = { for policy in local.policy_list : format("%s-%s", policy.role_name, policy.policy_name) => policy }

  name = each.value.policy_name
  policy = jsonencode({
    Version = each.value.version
    Statement = flatten([
      for resources in each.value.resources : [
        for details in resources.resource_details : [
          for regions in details.regions : {
            Effect = regions.Effect,
            Action = flatten([for permission in regions.permissions :
              [
                format("%s:%s", resources.name, permission)
            ]]),
            Resource = flatten([for name in regions.name :
              format("arn:aws:%s:%s:%s:%s",
                resources.name,
                contains(["iam", "s3", "route53"], resources.name) ? "" : regions.region,
                contains(["s3", "route53"], resources.name) ? "" : details.accountId,
              name)
            ])
          }
        ]
      ]
    ])
  })
}

# Define the IAM Roles
resource "aws_iam_role" "role" {
  for_each = {
    for role, roleconfig in var.role_config : role => roleconfig
  }
  name                 = each.key
  permissions_boundary = each.value.permissions_boundry_arn
  assume_role_policy = jsonencode({
    Version = each.value.assume_role_policy_document.Version,
    Statement = [for statement in each.value.assume_role_policy_document.Statement : {
      Effect = statement.Effect
      Action = [for action in statement.Action : action]
      Principal = {
        Service = [for service in statement.Principal.Service : service]
      }
      Sid = format("%s%s", statement.Effect, statement.SidSuffix)
    }]
  })
  depends_on = [aws_iam_policy.policy]
}

# Define the IAM Policy Attachments
resource "aws_iam_policy_attachment" "policy_attachment" {
  for_each = { for policy in local.policy_list : format("%s-%s", policy.role_name, policy.policy_name) => policy }

  name       = each.value.policy_name
  policy_arn = aws_iam_policy.policy[each.key].arn
  roles      = [each.value.role_name]
  depends_on = [aws_iam_policy.policy, aws_iam_role.role]
}