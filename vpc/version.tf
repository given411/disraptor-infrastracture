terraform {
required_version = "< 1.6.0"

  required_providers {
    aws = {

      source  = "hashicorp/aws"

      version = ">= 2.70.0"

    }
}
 backend "s3" {}
}
