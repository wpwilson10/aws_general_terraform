/*
Name: WPW AWS General Configuration
Description: Parent AWS Account for WPW Projects
Contributors: Patrick Wilson
*/

# S3 bucket for storing Terraform state
# Will be private and block public access by default
module "terraform_state_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.1"

  bucket = var.terraform_state_bucket

  versioning = {
    status = true
  }

  # Enable encryption
  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = true,
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

# DynamoDB table for Terraform state locking
module "terraform_state_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.2.0"

  name         = var.terraform_state_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}

# User whose access keys we will use to perform Terraform operations
module "terraform_admin" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.47.1"

  name = "terraform-admin"

  # Disables giving the user the ability to access AWS services through 
  #   the AWS Management Console 
  create_iam_user_login_profile = false
  create_iam_access_key         = true

  # Full admin access
  policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

# User for console access
module "iam_admin" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.47.1"

  name = "iam_admin"

  # user gets a login
  create_iam_user_login_profile = true
  create_iam_access_key         = true

  # Full admin access
  policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}
