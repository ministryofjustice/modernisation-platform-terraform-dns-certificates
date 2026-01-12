# Non-production module outputs
output "non_prod_certificate_domain" {
  description = "Certificate domain for non-production"
  value       = module.cert_module_non_prod.certificate_domain
}

output "non_prod_certificate_arn" {
  description = "ARN of the ACM certificate for non-production"
  value       = module.cert_module_non_prod.certificate_arn
}

output "non_prod_dns_validation_records" {
  description = "Route53 DNS validation records created in core-vpc zone for non-production"
  value       = module.cert_module_non_prod.dns_validation_records_core_vpc
}

output "non_prod_certificate_validation" {
  description = "Certificate validation resource for non-production"
  value       = module.cert_module_non_prod.certificate_validation_non_prod
}

# Production module outputs
output "prod_certificate_domain" {
  description = "Certificate domain for production"
  value       = module.cert_module_prod.certificate_domain
}

output "prod_certificate_arn" {
  description = "ARN of the ACM certificate for production"
  value       = module.cert_module_prod.certificate_arn
}

output "prod_dns_validation_records" {
  description = "Route53 DNS validation records created in core-network-services zone for production"
  value       = module.cert_module_prod.dns_validation_records_core_network_services
}

output "prod_certificate_validation" {
  description = "Certificate validation resource for production"
  value       = module.cert_module_prod.certificate_validation_prod
}