resource "aws_s3_bucket" "terraform_backend" {
  bucket        = var.TERRAFORM_BACKEND_BUCKET_NAME
  force_destroy = var.FORCE_DESTROY
}
