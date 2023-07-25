# These variables should match the env variables in the GitHub actions workflows
# These variables should match variables in the bootstrap folder

variable "ENV" {
  type        = string
  description = "Input the environment of the infrastructure: [test/prod]"
}

variable "ROOT_DOMAIN_NAME" {
  type        = string
  description = "E.g., abc.com."
  default     = "nathanwang.link"
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
      The first element in the list will be included in:
        * the name of the web root S3 bucket, and
        * the name of the logs S3 bucket.
    EOT
  default     = {
    test : ["test.nathanwang.link"],
    prod : ["www.nathanwang.link", "nathanwang.link"],
  }
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
