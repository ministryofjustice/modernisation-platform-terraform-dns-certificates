
locals {
  fqdn = var.is-production ? var.production_service_fqdn : trim(var.zone_name_core_vpc_public, ".")
}

resource "aws_acm_certificate" "certificate" {
  domain_name               = local.fqdn
  subject_alternative_names = var.is-production ? concat(
    ["*.${local.fqdn}"],
    [for prefix in var.subject_alternative_names : "${prefix}.${local.fqdn}"]
  ) : concat(
    ["*.${var.application_name}.${local.fqdn}"],
    [for prefix in var.subject_alternative_names : "${prefix}.${var.application_name}.${local.fqdn}"]
  )
  validation_method         = "DNS"
  tags                      = var.tags
  lifecycle {
    create_before_destroy = true
  }
}
