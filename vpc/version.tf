terraform {
required_version = ">= 1.0.0, < 1.5.0"

  required_providers {
    aws = {

      source  = "hashicorp/aws"

      version = ">= 2.70.0"

    }
}
 backend "s3" {}
}