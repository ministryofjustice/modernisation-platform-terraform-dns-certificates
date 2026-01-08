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


