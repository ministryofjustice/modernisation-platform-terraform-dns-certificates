output "cert_record" {
  value = aws_acm_certificate.certificate.domain_name

}
