module "cert_module_non_prod" {
  source = "../../"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  application_name                          = "testing"
  subject_alternative_names                 = ["*.db"]
  is-production                             = "false"
  zone_name_core_vpc_public                 = "platforms-test.modernisation-platform.service.justice.gov.uk"
  tags                                      = local.tags
}

module "cert_module_prod" {
  source = "../../"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  production_service_fqdn                   = "testing-test.modernisation-platform.service.justice.gov.uk"
  subject_alternative_names                 = ["*.db"]
  is-production                             = "true"
  zone_name_core_network_services_public    = "modernisation-platform.service.justice.gov.uk"
  tags                                      = local.tags
  depends_on = [module.cert_module_non_prod]
}
