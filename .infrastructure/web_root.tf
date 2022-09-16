resource "aws_s3_bucket" "web_root_test" {
  bucket        = "test.${var.DOMAIN_NAME}"
  force_destroy = false
}

resource "aws_s3_bucket_policy" "allow_cdn_read" {
  bucket = aws_s3_bucket.web_root_test.id
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
      "${aws_s3_bucket.web_root_test.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.this_environment.arn]
      variable = "AWS:SourceArn"
    }
  }
}

resource "aws_s3_object" "mock_index_page" {
  bucket       = aws_s3_bucket.web_root_test.bucket
  key          = "index.html"
  content      = "<h1>Hello, world</h1>"
  content_type = "text/html"
}

resource "aws_s3_object" "mock_error_page" {
  bucket       = aws_s3_bucket.web_root_test.bucket
  key          = "error.html"
  content      = "<h1>Error</h1>"
  content_type = "text/html"
}
