resource "aws_s3_bucket" "web_root_test" {
  bucket        = "${var.domain_name}-${var.project_name}-web-root-test"
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.web_root_test.bucket

  //noinspection HCLUnknownBlockType
  index_document {
    suffix = "index.html"
  }

  //noinspection HCLUnknownBlockType
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.web_root_test.id
  policy = data.aws_iam_policy_document.allow_public_read.json
}

data "aws_iam_policy_document" "allow_public_read" {
  statement {
    sid = "AllowPublicRead"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.web_root_test.arn,
      "${aws_s3_bucket.web_root_test.arn}/*",
    ]
  }
}

resource "aws_s3_object" "mock_index_page" {
  bucket = aws_s3_bucket.web_root_test.bucket
  key    = "index.html"
  content = "<h1>Hello, world</h1>"
  content_type = "text/html"
}

resource "aws_s3_object" "mock_error_page" {
  bucket = aws_s3_bucket.web_root_test.bucket
  key    = "error.html"
  content = "<h1>Error</h1>"
  content_type = "text/html"
}
