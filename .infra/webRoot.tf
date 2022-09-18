resource "aws_s3_bucket" "web_root_for_this_env" {
  bucket        = "${var.SUBDOMAIN_NAMES[var.ENV][0]}-web-root"
  force_destroy = var.FORCE_DESTROY
}

resource "aws_s3_bucket_policy" "allow_cdn_read" {
  bucket = aws_s3_bucket.web_root_for_this_env.id
  policy = data.aws_iam_policy_document.allow_cdn_read.json
}

data "aws_iam_policy_document" "allow_cdn_read" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject",]

    resources = [
      "${aws_s3_bucket.web_root_for_this_env.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.this_env.arn]
      variable = "AWS:SourceArn"
    }
  }
}
