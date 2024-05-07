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

resource "aws_route53_record" "cert_dns_validation_record" {
  provider = aws.core-vpc
  depends_on = [ aws_acm_certificate.certificate ]
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
    } 
  }
  zone_id  = data.aws_route53_zone.zone.zone_id
  name     = each.value.name
  records = [each.value.record]
  type     = var.record_type
  ttl     = 300

}


resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_dns_validation_record : record.fqdn]
}