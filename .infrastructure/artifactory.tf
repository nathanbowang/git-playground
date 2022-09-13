resource "aws_s3_bucket" "artifactory" {
  bucket        = "${var.DOMAIN_NAME}-${var.GITHUB_REPO_NAME}-artifactory"
  force_destroy = true
}