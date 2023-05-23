resource "aws_route53_record" "www-dev" {
  zone_id = var.zone
  name    = var.dns_name
  type    = var.record_type
    alias {
      name                   = var.alias_dns_name
      zone_id                = var.alias_zone
      evaluate_target_health = true
  }
  }


