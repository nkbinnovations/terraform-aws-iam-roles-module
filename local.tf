# File: local.tf
#
# This file contains the local values that are used in the main.tf file.
# The local values are used to create a map of the policies that are applied to the roles.
# The map is then used to create the IAM policies in the aws_iam_policy resource.
# The local values are defined using the locals block.
locals {
  policy_list = flatten([
    for role, roleconfig in var.role_config : [
      for policy, details in roleconfig.policies : {
        policy_name = policy,
        role_name   = role,
        version     = details.version,
        resources   = details.resources
      }
    ]
  ])
}
