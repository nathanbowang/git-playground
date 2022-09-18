# These variables should match the values in the GitHub actions workflows
# These variables should match variables in the upper folder

variable "ARTIFACTORY_BUCKET_NAME" {
  type        = string
  description = "This is a global artifactory for the AWS account. E.g., my-artifactory."
  default     = "global-artifactory"
}

variable "TERRAFORM_BACKEND_BUCKET_NAME" {
  type        = string
  description = "This is a global TF state store for the AWS account. E.g., my-terraform-backend."
  default     = "global-terraform-backend"
}

variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "ap-southeast-2"
}

variable "FORCE_DESTROY" {
  type    = bool
  description = <<EOT
      If true, an S3 bucket could be destroyed with objects.
      If false, an S3 bucket can only be destroyed if empty.
    EOT
  default = true
}
