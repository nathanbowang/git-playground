resource "aws_s3_bucket" "artifactory" {
  bucket        = var.ARTIFACTORY_BUCKET_NAME
  force_destroy = true
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${var.SUBDOMAIN_NAMES[var.ENV][0]}-logs"
  force_destroy = true
}
