# Defines Outputs for the Terraform module

output "role_arn" {
  value = { for role in aws_iam_role.role : role.name => role.arn }
}