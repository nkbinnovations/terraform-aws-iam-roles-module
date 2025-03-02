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
| <a name="input_role_definition"></a> [role\_definition](#input\_role\_definition) | Custom role definition to create for the Managed Identity. <br>    **Example:** {<br>  "test-role-free-from-file": {<br>    "description": "This is a test role",<br>    "permissions_boundry_arn": "arn:aws:iam::123456789987:policy/developer",<br>    "assume_role_policy_document": {<br>      "Version": "2012-10-17",<br>      "Statement": [<br>        {<br>          "Effect": "Allow",<br>          "Action": [<br>            "sts:AssumeRole"<br>          ],<br>          "Principal": {<br>            "Service": [<br>              "ec2.amazonaws.com",<br>              "ssm.amazonaws.com"<br>            ]<br>          },<br>          "SidSuffix": "AssumeRole"<br>        }<br>      ]<br>    },<br>    "policies": {<br>      "test-policy-1": {<br>        "version": "2012-10-17",<br>        "resources": [<br>          {<br>            "name": "ds",<br>            "resource_details": [<br>              {<br>                "accountId": 123456789987,<br>                "regions": [<br>                  {<br>                    "region": "eu-west-1",<br>                    "Effect": "Allow",<br>                    "name": [<br>                      "*"<br>                    ],<br>                    "permissions": [<br>                      "*"<br>                    ]<br>                  }<br>                ]<br>              }<br>            ]<br>          }<br>        ]<br>      }<br>    }<br>  }<br>}<br> | `null` | no | yes |


## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The AWS ARN for the role created |
