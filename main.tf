
data "aws_route53_zone" "public_zone_core_vpc" {
  count = var.is-production ? 0 : 1
  provider = aws.core-vpc
  name     = var.zone_name_core_vpc_public
  private_zone = false
}

data "aws_route53_zone" "public_zone_core_network_services" {
  count = var.is-production ? 1 : 0
  provider = aws.core-network-services
  name     = var.zone_name_core_network_services_public
  private_zone = false
}

locals {
  fqdn = var.is-production ? trim(var.zone_name_core_network_services_public, ".") : trim(var.zone_name_core_vpc_public, ".")
  # Create a map of unique validation records by resource_record_name
  validation_records = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options :
    dvo.resource_record_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
}

resource "aws_acm_certificate" "certificate" {
  domain_name               = local.fqdn
  subject_alternative_names = concat(
    ["${var.application_name}.${local.fqdn}", "*.${var.application_name}.${local.fqdn}"],
    [for prefix in var.subject_alternative_names : "${prefix}.${var.application_name}.${local.fqdn}"]
  )
  validation_method         = "DNS"
  tags                      = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dns_validation_record_core_vpc" {
  provider = aws.core-vpc
  for_each = var.is-production ? {} : local.validation_records
  
  zone_id = data.aws_route53_zone.public_zone_core_vpc[0].zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

resource "aws_route53_record" "dns_validation_record_core_network_services" {
  provider = aws.core-network-services
  for_each = var.is-production ? local.validation_records : {}
  
  zone_id = data.aws_route53_zone.public_zone_core_network_services[0].zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
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
