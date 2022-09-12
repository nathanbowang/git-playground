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
