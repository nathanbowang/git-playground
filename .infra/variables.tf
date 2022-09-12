variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "region" {
  type        = string
  description = "AWS region."
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

variable "github_workspace_name" {
  type        = string
  description = "Workspace name."
}

variable "github_repo_name" {
  type        = string
  description = "Repo name."
}
