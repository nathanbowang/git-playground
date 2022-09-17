variable "ENV" {
  type        = string
  description = "Input the environment of the infrastructure: [test/prod]"
}

variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "ap-southeast-2"
}


variable "ROOT_DOMAIN_NAME" {
  type    = string
  description = "E.g., abc.com."
}

variable "SUBDOMAIN_NAMES" {
  type        = map(list(string))
  description = <<EOT
      E.g.:
      {
        test : ["test.abc.com"],
        prod : ["www.abc.com", "abc.com"],
      }
      The keys should be the env options.
      The first element in the list will be the name of the web root S3 bucket.
    EOT
}

variable "ARTIFACTORY_BUCKET_NAME" {
  type        = string
  description = "E.g., abc-ui-artifactory or abc-identity-microservice-artifactory. "
}

variable "LOGS_BUCKET_NAME" {
  type        = string
  description = "E.g., logs. "
}

variable "LOGS_PREFIX" {
  type        = map(string)
  description = <<EOT
      E.g.:
      {
        test: "nathanwang.link-ui-test/",
        prod: "nathanwang.link-ui-prod/",
      }
    EOT
}

variable "GITHUB_ACCOUNT_NAME" {
  type = string
  description = "natebowang"
}

variable "GITHUB_REPO_NAME" {
  type = string
  description = "my-ui-repo"
}

variable "COMMON_TAGS" {
  description = "Common tags you want to be applied to all components."
}
