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
  value       = aws_route53_record.dns_validation_record_core_vpc
}

output "certificate_validation_non_prod" {
  description = "Certificate validation resource for non-production"
  value       = aws_acm_certificate_validation.non_prod[0]
}