# This file should be identical to the ../provider.tf

data "external" "get_git_info" {
  program = [
    "bash", "-c", <<EOT
      echo '{'\
        "\"infra-git-origin\":\"$(git remote get-url origin)\","\
        "\"infra-git-commit-hash\":\"$(git rev-parse HEAD)\","\
        "\"infra-provisioned-from-path\":\"$(git rev-parse --show-prefix)\","\
        "\"infra-updated-by\":\"$(git config --get user.name)\""\
      '}'
    EOT
  ]
}

locals {
  defaultTags = merge(
    {
      "infra-last-updated-utc-time": timestamp()
    },
    data.external.get_git_info.result
  )
  ignoreTagsKeys = [
    "artifact-git-commit-hash",
    "artifact-updated-by",
    "artifact-last-updated-utc-time"
  ]
}

terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # TODO: s3 state
}

provider "aws" {
  region = var.AWS_DEFAULT_REGION
  default_tags { tags = local.defaultTags }
  ignore_tags { keys = local.ignoreTagsKeys }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  default_tags { tags = local.defaultTags }
  ignore_tags { keys = local.ignoreTagsKeys }
}
