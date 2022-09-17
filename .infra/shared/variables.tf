# These variables should match the values in the GitHub actions workflows
# These variables should match variables in the upper folder

variable "ARTIFACTORY_BUCKET_NAME" {
  type        = string
  description = "E.g., my-ui-artifactory. "
  default     = "git-playground-artifactory"
}

variable "GITHUB_ACCOUNT_NAME" {
  type    = string
  default = "natebowang"
}

variable "GITHUB_REPO_NAME" {
  type        = string
  description = "my-ui"
  default     = "git-playground"
}

variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "ap-southeast-2"
}
