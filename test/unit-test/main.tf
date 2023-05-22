
module "dns_mod" {
  source                   = "../../"
  zone_id                  = "modernisation-platform.service.justice.gov.uk"
  dns_name                 = local.application_name
  type                     = "cname"
  gandi_certificate_needed = "0"
  acm_certificate_needed   = "0"



  tags = local.tags
}
