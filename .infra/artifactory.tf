resource "aws_s3_bucket" "artifactory" {
  bucket        = "${var.domain_name}-${var.project_name}-artifactory"
  force_destroy = true
}