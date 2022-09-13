variable "DOMAIN_NAME" {
  type        = string
  description = "The domain name for the website."
}

variable "REGION" {
  type        = string
  description = "AWS region."
}

variable "COMMON_TAGS" {
  description = "Common tags you want applied to all components."
}

variable "GITHUB_WORKSPACE_NAME" {
  type        = string
  description = "Workspace name."
}

variable "GITHUB_REPO_NAME" {
  type        = string
  description = "Repo name."
}
