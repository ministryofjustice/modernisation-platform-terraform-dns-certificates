# provider "aws" {
#   alias  = "core-vpc"
#   region = "eu-west-2"
#   assume_role {
#     role_arn = "arn:aws:iam::${local.environment_management.account_ids[local.provider_name]}:role/member-delegation-${local.vpc_name}-${local.app_name}"
#   }
# }

module "cert_module" {
  source = "../../"
  providers = {
    aws.core-vpc = aws.core-vpc

  }
  aws_account_id = local.environment_management.account_ids
  record_type = "CNAME"
  fqdn        = "platforms-test.modernisation-platform.service.justice.gov.uk"
  app_name = local.application_name
  #environment_management = local.environment_management
  provider_name = local.provider_name

  tags = local.tags
 
}
