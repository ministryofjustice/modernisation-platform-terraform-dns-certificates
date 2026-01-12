# Modernisation Platform DNS Certificates Module

[![repo standards badge](https://github-community.service.justice.gov.uk/repository-standards/api/modernisation-platform-terraform-dns-certificates/badge)](https://github-community.service.justice.gov.uk/repository-standards/modernisation-platform-terraform-dns-certificates)

## Usage

This module provides a means by which users can create AWS ACM Certificates along with the required DNS validations. These validations support both non-production accounts using the core-vpc-external hosted zone data sources as well as production hosted zones defined in core-network-services.

**NOTE: In all circumstances we recommend pinning the version of the module using the commit hash. See Github documentation for further information.**

For Non-Production accounts. Note that application_name is required for non-production use.

For Production accounts, the required domain usage delegation and hosted zone must be implemented before creating resources using this module. Please speak to the modernisation-platform team for further information on this.

```hcl
module "cert_module" {
  source = "https://github.com/ministryofjustice/modernisation-platform-terraform-dns-certificates"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  application_name                          = local.application_name
  subject_alternative_names                 = ["*.db"]
  is-production                             = local.is-production
  production_service_fqdn                   = ""
  zone_name_core_vpc_public                 = data.aws_route53_zone.external.name
  tags                                      = local.tags
}
```

For Production Accounts:

```hcl
module "cert_module" {
  source = "https://github.com/ministryofjustice/modernisation-platform-terraform-dns-certificates"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  application_name                          = local.application_name
  subject_alternative_names                 = ["*.webapp"]
  is-production                             = local.is-production
  production_service_fqdn                   = "servicename.service.justice.gov.uk"
  zone_name_core_vpc_public                 = "servicename.service.justice.gov.uk
  tags                                      = local.tags
}
```

Where **servicename** is the agreed name for the application adhering to organisation public domain naming [standards](https://cloud-optimisation-and-accountability.justice.gov.uk/documentation/operations-engineering-legacy/operations-engineering-user-guide/dns/domain-naming-standard.html).

For further information - please refer to our [User Guide](https://user-guide.modernisation-platform.service.justice.gov.uk/user-guide/how-to-configure-dns.html) on the subject.

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |
| <a name="provider_aws.core-network-services"></a> [aws.core-network-services](#provider\_aws.core-network-services) | ~> 6.0 |
| <a name="provider_aws.core-vpc"></a> [aws.core-vpc](#provider\_aws.core-vpc) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.non_prod](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_acm_certificate_validation.prod](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.dns_validation_record_core_network_services](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.dns_validation_record_core_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.core_network_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_route53_zone.zone_core_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The application name to be used in non-production deployments | `string` | `""` | no |
| <a name="input_is-production"></a> [is-production](#input\_is-production) | Whether the environment is production or not | `bool` | n/a | yes |
| <a name="input_production_service_fqdn"></a> [production\_service\_fqdn](#input\_production\_service\_fqdn) | The fully qualified domain name for production deployments | `string` | `""` | no |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | Additional subject alternate name prefixes to add beyond the default values. There are *.fqdn and *.application\_name.fqdn | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to be used by all resources | `map(string)` | n/a | yes |
| <a name="input_zone_name_core_network_services_public"></a> [zone\_name\_core\_network\_services\_public](#input\_zone\_name\_core\_network\_services\_public) | Route53 core-network-services public hosted zone ID for certificate validation. Required for production deployments | `string` | `""` | no |
| <a name="input_zone_name_core_vpc_public"></a> [zone\_name\_core\_vpc\_public](#input\_zone\_name\_core\_vpc\_public) | Route53 core-vpc public hosted zone name for certificate validation. Required for non-production deployments | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ARN of the ACM certificate |
| <a name="output_certificate_domain"></a> [certificate\_domain](#output\_certificate\_domain) | n/a |
| <a name="output_certificate_domain_validation_options"></a> [certificate\_domain\_validation\_options](#output\_certificate\_domain\_validation\_options) | Domain validation options for the certificate - used for DNS validation in another module |
| <a name="output_certificate_id"></a> [certificate\_id](#output\_certificate\_id) | ID of the ACM certificate |
| <a name="output_certificate_validation_non_prod"></a> [certificate\_validation\_non\_prod](#output\_certificate\_validation\_non\_prod) | Certificate validation resource for non-production |
| <a name="output_certificate_validation_prod"></a> [certificate\_validation\_prod](#output\_certificate\_validation\_prod) | Certificate validation resource for production |
| <a name="output_dns_validation_records_core_network_services"></a> [dns\_validation\_records\_core\_network\_services](#output\_dns\_validation\_records\_core\_network\_services) | Route53 DNS validation records created in core-network-services zone |
| <a name="output_dns_validation_records_core_vpc"></a> [dns\_validation\_records\_core\_vpc](#output\_dns\_validation\_records\_core\_vpc) | Route53 DNS validation records created in core-vpc zone |
<!-- END_TF_DOCS -->
