variable "ENV" {
  type        = string
  description = "Input the environment of the infrastructure: [test/prod]"
}

variable "ARTIFACTORY_BUCKET_NAME" {
  type        = string
  description = "E.g., abc-ui-artifactory or abc-identity-microservice-artifactory. "
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
      The first element in the list will be:
        * the name of the web root S3 bucket, and
        * the prefix of the name of the logs S3 bucket.
    EOT
}

variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "ap-southeast-2"
}
