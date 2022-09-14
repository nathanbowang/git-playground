data "aws_route53_zone" "public" {
  name = var.DOMAIN_NAME
}

resource "aws_route53_record" "test" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "test.${var.DOMAIN_NAME}"
  type    = "A"

  alias {
    //noinspection HILUnresolvedReference
    name                   = aws_s3_bucket_website_configuration.this.website_domain
    zone_id                = aws_s3_bucket.web_root_test.hosted_zone_id
    evaluate_target_health = true
  }
}

# TODO: HTTPS
resource "aws_acm_certificate" "test" {
  domain_name       = aws_route53_record.test.name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

//noinspection HILUnresolvedReference
resource "aws_route53_record" "test_cert_validation_record" {
  for_each = {
  for dvo in aws_acm_certificate.test.domain_validation_options : dvo.domain_name => {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = 600
  zone_id         = data.aws_route53_zone.public.zone_id
}

resource "aws_acm_certificate_validation" "test" {
  certificate_arn         = aws_acm_certificate.test.arn
  validation_record_fqdns = [for record in aws_route53_record.test_cert_validation_record : record.fqdn]
}
