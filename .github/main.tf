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

module "gandi_certificate" {
  source = "./certificates"
  private_key = var.ssm_private_key.value
  certificate_body = var
  certificate_chain = var.


}