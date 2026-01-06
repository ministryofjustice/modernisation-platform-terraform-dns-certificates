output "certificate_domain" {
  value = aws_acm_certificate.certificate.domain_name
}

output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.certificate.arn
}

output "certificate_id" {
  description = "ID of the ACM certificate"
  value       = aws_acm_certificate.certificate.id
}

output "certificate_domain_validation_options" {
  description = "Domain validation options for the certificate - used for DNS validation in another module"
  value       = aws_acm_certificate.certificate.domain_validation_options
}

output "dns_validation_records_core_vpc" {
  description = "Route53 DNS validation records created in core-vpc zone"
  value       = !var.is-production ? aws_route53_record.dns_validation_record_core_vpc : null
}

output "dns_validation_records_core_network_services" {
  description = "Route53 DNS validation records created in core-network-services zone"
  value       = var.is-production ? aws_route53_record.dns_validation_record_core_network_services : null
}

output "certificate_validation_prod" {
  description = "Certificate validation resource for production"
  value       = var.is-production ? aws_acm_certificate_validation.prod[0] : null
}

output "certificate_validation_non_prod" {
  description = "Certificate validation resource for non-production"
  value       = !var.is-production ? aws_acm_certificate_validation.non_prod[0] : null
}


