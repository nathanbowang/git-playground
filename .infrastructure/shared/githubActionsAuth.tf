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

resource "aws_iam_openid_connect_provider" "auth_server" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions" {
  name                = "GitHubActionsRole"
  assume_role_policy  = data.aws_iam_policy_document.github_actions.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudFrontFullAccess",
  ]
}

data "aws_iam_policy_document" "github_actions" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.auth_server.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.GITHUB_ACCOUNT_NAME}/${var.GITHUB_REPO_NAME}:*"]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
  }
}
