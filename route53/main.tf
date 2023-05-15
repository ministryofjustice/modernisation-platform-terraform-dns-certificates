resource "aws_route53_record" "www-dev" {
  zone_id = var.zone
  name    = var.dns_name
  type    = var.record_type
  ttl     = 60

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = var.set_identifier
  records        = ["dev.example.com"]
}

resource "aws_acm_certificate" "acm_certificate" {

  domain_name   = aws_route53_record.www-dev.fqdn
  validation_method = "DNS"
  subject_alternative_names = var.environment == "production" ? null : [local.domain_name]
  
  tags = var.tags
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = var.environment != "production" ? [local.domain_name_main[0], local.domain_name_sub[0]] : [local.domain_name_main[0]]

  timeouts {
    create = "10m"
  }
  lifecycle {
    prevent_destroy = false
  }
}