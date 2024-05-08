resource "aws_acm_certificate" "certificate" {
  domain_name       = var.fqdn
  validation_method = "DNS"

  tags = var.tags
  lifecycle {
    create_before_destroy = true
  }
}
data "aws_route53_zone" "zone" {
  provider = aws.core-vpc
  name         = var.fqdn
  private_zone = false
}

resource "aws_route53_record" "dns_validation_record_production" {
  provider = aws.core-network-services
  count = var.is-production ? 1 : 0
  depends_on = [ aws_acm_certificate.certificate ]
  zone_id  = data.aws_route53_zone.zone.zone_id
  name     = aws_acm_certificate.certificate.CNAME
  records = aws_acm_certificate.certificate.resource_record_name
  type     = var.record_type
  ttl     = 300

}
resource "aws_route53_record" "dns_validation_record_nonproduction" {
  provider = aws.core-vpc
  count = var.is-production ? 0 : 1
  depends_on = [ aws_acm_certificate.certificate ]
  zone_id  = data.aws_route53_zone.zone.zone_id
  name     = aws_acm_certificate.certificate.CNAME
  records = aws_acm_certificate.certificate.resource_record_name
  type     = var.record_type
  ttl     = 300

}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_dns_validation_record : record.fqdn]
}