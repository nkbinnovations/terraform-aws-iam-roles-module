# # Description: Define the input variables for the module
# #
# # Input variables

variable "role_definition" {
  description = <<DESC
  {
    "test-role-free-from-file" : {
      "description": "This is a test role",
      "permissions_boundry_arn": "arn:aws:iam::330361095321:policy/ccoe/js-developer",
      "assume_role_policy_document": {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Action": [
              "sts:AssumeRole"
            ],
            "Principal": {
              "Service": [
                "ec2.amazonaws.com",
                "ssm.amazonaws.com"
              ]
            },
            "SidSuffix": "AssumeRole"
          }
        ]
      },
      "policies": {
        "test-policy-1" : {
          "version": "2012-10-17",
          "resources": [
            {
              "name": "ds",
              "resource_details": [
                {
                  "accountId": 123456789987,
                  "regions": [
                    {
                      "region": "eu-west-1",
                      "Effect": "Allow",
                      "name": [
                        "*"
                      ],
                      "permissions": [
                        "*"
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "name": "sns",
              "resource_details": [
                {
                  "accountId": 123456789987,
                  "regions": [
                    {
                      "region": "eu-west-1",
                      "Effect": "Allow",
                      "name": [
                        "*"
                      ],
                      "permissions": [
                        "*"
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        },
        "test-policy-2" : {
          "version": "2012-10-17",
          "resources": [
            {
              "name": "autoscaling",
              "resource_details": [
                {
                  "accountId": 123456789987,
                  "regions": [
                    {
                      "region": "eu-west-1",
                      "Effect": "Allow",
                      "name": [
                        "MF-RAPSEC-*",
                        "MOBILEFARM-*"
                      ],
                      "permissions": [
                        "UpdateAutoScalingGroup",
                        "DescribeAutoScalingGroups"
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "name": "sns",
              "resource_details": [
                {
                  "accountId": 123456789987,
                  "regions": [
                    {
                      "region": "eu-west-1",
                      "Effect": "Deny",
                      "name": [
                        "*"
                      ],
                      "permissions": [
                        "*"
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    }
  }
  DESC
  type = map(object({
    description             = string
    permissions_boundry_arn = string
    assume_role_policy_document = object({
      Version = string
      Statement = list(object({
        Effect = string
        Principal = object({
          Service = set(string)
        })
        Action    = set(string)
        SidSuffix = string
      }))
    })
    policies = map(object({
      version = string
      resources = list(object({
        name = string
        resource_details = list(object({
          accountId = number
          regions = list(object({
            region      = string
            Effect      = string
            name        = set(string)
            permissions = set(string)
          }))
        }))
      }))
    }))
  }))
  validation {
    condition     = alltrue([for role in var.role_definition : length(keys(role.policies)) <= 10])
    error_message = "Each role should have at most 10 custom managed policy"
  }
}
