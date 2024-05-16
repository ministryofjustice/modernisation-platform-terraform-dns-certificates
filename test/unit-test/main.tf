module "cert_module" {
  source         = "../../"
  providers      = {
    aws.core-network-services = aws.core-network-services
  }
  aws_account_id = local.environment_management.account_ids
  record_type    = "CNAME"
  fqdn           = "platforms-test.modernisation-platform.service.justice.gov.uk"
  app_name       = local.application_name
  provider_name  = local.provider_name
  is-production  = "false"
  tags           = local.tags

}
