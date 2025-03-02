# terraform-aws-iam-roles-module
Terraform module to allow AWS users to create IAM roles and attach policy tocreated role

## Requirements
No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="role_definition"></a> [role\_definition](#input\_role\_definition) | Custom role definition to create for the Managed Identity. <br>    **Example:**
```json
{
    "test-role-free-from-file" : {
      "description" : "This is a test role",
      "permissions_boundry_arn" : "arn:aws:iam::123456789987:policy/developer",
      "assume_role_policy_document" : {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "sts:AssumeRole"
            ],
            "Principal" : {
              "Service" : [
                "ec2.amazonaws.com",
                "ssm.amazonaws.com"
              ]
            },
            "SidSuffix" : "AssumeRole"
          }
        ]
      },
      "policies" : {
        "test-policy-1" : {
          "version" : "2012-10-17",
          "resources" : [
            {
              "name" : "ds",
              "resource_details" : [
                {
                  "accountId" : 123456789987,
                  "regions" : [
                    {
                      "region" : "eu-west-1",
                      "Effect" : "Allow",
                      "name" : [
                        "*"
                      ],
                      "permissions" : [
                        "*"
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        },
      }
    },
  }
```
 | `null` | no |


## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |


## Outputs

| Name | Description |
|------|-------------|
| <a name="role_arn"></a> [role\_arn](#output\role\_arn) | The AWS ARN for the role created |
