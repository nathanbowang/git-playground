# These variables should match the values in the GitHub actions workflows
# These variables should match variables in the upper folder

variable "ARTIFACTORY_BUCKET_NAME" {
  type        = string
  description = "E.g., my-ui-artifactory. "
  default     = "git-playground-artifactory"
}

variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "ap-southeast-2"
}
