data "aws_route53_zone" "public" {
  name = var.DOMAIN_NAME
}

resource "aws_route53_record" "test_a" {
  zone_id = data.aws_route53_zone.public.zone_id
  name = "test.${var.DOMAIN_NAME}"
  type = "A"

  alias {
    //noinspection HILUnresolvedReference
    name = aws_s3_bucket_website_configuration.this.website_domain
    zone_id = aws_s3_bucket.web_root_test.hosted_zone_id
    evaluate_target_health = true
  }
}

#resource "aws_acm_certificate" "this" {
#  domain_name       = var.DOMAIN_NAME
#  validation_method = "DNS"
#}
#
#resource "aws_acm_certificate_validation" "this" {
#  certificate_arn         = aws_acm_certificate.this.arn
#  validation_record_fqdns = [aws_route53_record.root_a.fqdn, aws_route53_record.www_a.fqdn]
#}