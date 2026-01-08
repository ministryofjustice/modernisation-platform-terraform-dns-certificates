module "cert_module" {
  source = "../../"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  application_name                = "testing"
  zone_name_core_vpc_public       = "platforms-test.modernisation-platform.service.justice.gov.uk"
  is-production                   = false
  subject_alternative_names       = []
  tags                            = local.tags
}
