resource "aws_acm_certificate" "this_env" {
  domain_name               = var.SUBDOMAIN_NAMES[var.ENV][0]
  subject_alternative_names = var.SUBDOMAIN_NAMES[var.ENV]
  validation_method         = "DNS"
  provider                  = aws.virginia

  lifecycle {
    create_before_destroy = true
  }
}

//noinspection HILUnresolvedReference
resource "aws_route53_record" "validation_records" {
  for_each = {
  for dvo in aws_acm_certificate.this_env.domain_validation_options : dvo.domain_name => {
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

resource "aws_acm_certificate_validation" "this_env" {
  certificate_arn         = aws_acm_certificate.this_env.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_records : record.fqdn]
  provider                = aws.virginia
}

