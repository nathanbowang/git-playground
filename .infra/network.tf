resource "aws_cloudfront_distribution" "this_env" {
  enabled             = true
  is_ipv6_enabled     = true
  aliases             = var.SUBDOMAIN_NAMES[var.ENV]
  default_root_object = "index.html"
  http_version        = "http2and3"

  origin {
    domain_name              = aws_s3_bucket.web_root_for_this_env.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.web_root_for_this_env.id
    origin_access_control_id = aws_cloudfront_origin_access_control.allow_cdn_read.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.web_root_for_this_env.id
    compress         = true

    forwarded_values {
      query_string = true
      cookies { forward = "none" }
      headers      = ["Origin"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.this_env.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  logging_config {
    include_cookies = true
    bucket          = aws_s3_bucket.logs.bucket_domain_name
  }
}

resource "aws_cloudfront_origin_access_control" "allow_cdn_read" {
  name                              = "allow-cdn-read"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_route53_zone" "public" {
  name = var.ROOT_DOMAIN_NAME
}

resource "aws_route53_record" "this_env" {
  for_each = toset(var.SUBDOMAIN_NAMES[var.ENV])

  zone_id = data.aws_route53_zone.public.zone_id
  name    = each.key
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this_env.domain_name
    zone_id                = aws_cloudfront_distribution.this_env.hosted_zone_id
    evaluate_target_health = true
  }
}
