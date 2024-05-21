module "cert_module" {
  source = "../../"
  providers = {
    aws.core-vpc = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  fqdn           = "platforms-test.modernisation-platform.service.justice.gov.uk"
  is-production  = "false"
  tags           = local.tags

}
