# provider "aws" {
#   alias  = "core-vpc"
#   region = "eu-west-2"
#   assume_role {
#     role_arn = "arn:aws:iam::${var.environment_management.account_ids[var.provider_name]}:role/member-delegation-${local.vpc_name}-${var.app_name}"
#   }
# }


resource "aws_acm_certificate" "certificate" {
  domain_name       = var.fqdn
  validation_method = "DNS"

  tags = var.tags
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "cert_validation" {
  provider   = aws.core-vpc
  depends_on = [aws_acm_certificate.certificate]
  for_each = {
    for val in aws_acm_certificate.certificate.domain_validation_options : val.domain_name => {
      name   = val.resource_record_name
      record = val.resource_record_value
      type   = val.resource_record_type
    }
  }
  zone_id = var.fqdn
  name    = each.value.name
  records = [each.value.record]
  type    = var.record_type
}


resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}