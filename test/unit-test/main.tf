module "cert_module" {
  source = "../../"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  application_name                          = "testing"
  subject_alternative_names                 = ["*.db"]
  is-production                             = "false"
  production_service_fqdn                   = ""
  zone_name_core_vpc_public                 = "platforms-test.modernisation-platform.service.justice.gov.uk"
  tags                                      = local.tags
}
