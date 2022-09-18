resource "aws_s3_bucket" "artifactory" {
  bucket        = var.ARTIFACTORY_BUCKET_NAME
  force_destroy = var.FORCE_DESTROY
}
