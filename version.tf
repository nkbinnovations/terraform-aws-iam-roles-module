#This is the common terraform Version file for all root Modules
#This file will be copied to all root modules during execution.
#Provider block should be added in providers.tf file under root module to ensure usage of single provider
#Any usage of new providers should be added with version numbers for consistency across modules
#All child modulues invoked will be added with module specific versions.tf with providers constraints
#     as below
#     1. version = ">=1.2.0"
#     2. version = ">=1.2.0,<=2.2.0"
#     3. version = "=1.2.0"

terraform {
  #Specify the base terraform version needed for running the scripts
  required_version = "~>1.10.3"

  required_providers {

    # AWS Modules needed for the Infrastructure
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.89.0"
    }
  }
}
