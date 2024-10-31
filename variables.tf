variable "terraform_state_bucket" {
  description = "Name of the S3 bucket used to store Terraform backend state"
  type        = string
}

variable "terraform_state_table" {
  description = "Name of the DynamoDB table used to lock Terraform backend state"
  type        = string
  default     = "terraform-state-lock"
}

variable "region" {
  description = "AWS Region to use for this account"
  type        = string
  default     = "us-east-1"
}

# Uses the access credential values in the profile located at
#  "~/.aws/credentials" (Linux) or "%USERPROFILE%\.aws\credentials" (Windows).
# See https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
variable "credentials_profile" {
  description = "Profile to use from the AWS credentials file"
  type        = string
  default     = "default"
}
