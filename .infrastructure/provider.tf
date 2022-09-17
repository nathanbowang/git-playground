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
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}