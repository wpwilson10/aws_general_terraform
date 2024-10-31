terraform {
  required_version = "1.9.7"

  backend "s3" {
    # can't use variables here :(
    bucket         = "wpw-terraform-state"
    key            = "general-state"
    dynamodb_table = "terraform-state-lock"
    region         = "us-east-1"

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}
