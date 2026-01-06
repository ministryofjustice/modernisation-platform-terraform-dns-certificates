
data "aws_route53_zone" "public_zone_core_vpc" {
  count = var.is-production ? 0 : 1
  provider = aws.core-vpc
  zone_id  = var.zone_id_core_vpc_public
}

data "aws_route53_zone" "public_zone_core_network_services" {
  count = var.is-production ? 1 : 0
  provider = aws.core-network-services
  zone_id  = var.zone_id_core_network_services_public
}

locals {
  fqdn = var.is-production ? var.production_service_fqdn : "${var.application_name}.${trim(data.aws_route53_zone.public_zone_core_vpc[0].name, ".")}"
  domain_validation_records = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
    }
  }
}

resource "aws_acm_certificate" "certificate" {
  domain_name               = local.fqdn
  subject_alternative_names = concat(["*.${local.fqdn}"], [for prefix in var.subject_alternative_names : "${prefix}.${local.fqdn}"])
  validation_method         = "DNS"
  tags                      = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dns_validation_record_core_vpc" {
  provider   = aws.core-vpc
  depends_on = [aws_acm_certificate.certificate]
  ttl        = 300
  type       = "CNAME"
  for_each = var.is-production ? {} : local.domain_validation_records
  zone_id = var.zone_id_core_vpc_public
  name    = each.value.name
  records = [each.value.record]
}

resource "aws_route53_record" "dns_validation_record_core_network_services" {
  provider   = aws.core-network-services
  depends_on = [aws_acm_certificate.certificate]
  ttl        = 300
  type       = "CNAME"
  for_each = var.is-production ? local.domain_validation_records : {}
  zone_id = var.zone_id_core_network_services_public
  name    = each.value.name
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "prod" {
  count                   = var.is-production ? 1 : 0
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.dns_validation_record_core_network_services : record.fqdn]
}
resource "aws_acm_certificate_validation" "non_prod" {
  count                   = var.is-production ? 0 : 1
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.dns_validation_record_core_vpc : record.fqdn]
}
