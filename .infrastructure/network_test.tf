resource "aws_route53_zone" "this" {
  name = var.DOMAIN_NAME
}

resource "aws_route53_record" "root_a" {
  zone_id = aws_route53_zone.this.zone_id
  name = var.DOMAIN_NAME
  type = "A"

  alias {
    //noinspection HILUnresolvedReference
    name = aws_s3_bucket_website_configuration.this.website_endpoint
    zone_id = aws_s3_bucket.web_root_test.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_a" {
  zone_id = aws_route53_zone.this.zone_id
  name = "www.${var.DOMAIN_NAME}"
  type = "A"

  alias {
    //noinspection HILUnresolvedReference
    name = aws_s3_bucket_website_configuration.this.website_endpoint
    zone_id = aws_s3_bucket.web_root_test.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.DOMAIN_NAME
  validation_method = "DNS"
}