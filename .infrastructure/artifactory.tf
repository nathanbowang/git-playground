resource "aws_s3_bucket" "artifactory" {
  bucket        = var.ARTIFACTORY_NAME
  force_destroy = false
}