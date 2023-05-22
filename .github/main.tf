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
resource "aws_acm_certificate" "tch-cert" {
  count = var.gandi_certificate_needed ? 1 : 0
  private_key=file(var.private_key)
  certificate_body = file(var.certificate_body)
  certificate_chain=file(var.var.certificate_chain)
  }

resource "aws_acm_certificate" "acm_certificate" {
  count             = var.acm_certificate_needed ? 1 : 0
  domain_name       = aws_route53_record.www-dev.fqdn
  validation_method = "DNS"

  tags = var.tags
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  depends_on              = [aws_acm_certificate.acm_certificate]
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = var.environment != "production" ? [local.domain_name_main[0], local.domain_name_sub[0]] : [local.domain_name_main[0]]

  timeouts {
    create = "10m"
  }
  lifecycle {
    prevent_destroy = false
  }
}
