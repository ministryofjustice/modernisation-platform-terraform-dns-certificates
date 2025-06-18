# Modernisation Platform Certification Module

[![repo standards badge](https://github-community.service.justice.gov.uk/repository-standards/api/modernisation-platform-terraform-dns-certificates/badge)](https://github-community.service.justice.gov.uk/repository-standards/modernisation-platform-terraform-dns-certificates)

## Usage

```hcl
module "cert_module" {
  source = "https://github.com/ministryofjustice/modernisation-platform-terraform-dns-certificates"
  providers = {
    aws.core-vpc              = aws.core-vpc
    aws.core-network-services = aws.core-network-services
  }
  fqdn          = ""
  is-production = ""
  tags          = local.tags

}


```
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
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | DNS name to be used with the zone | `string` | n/a | yes |
| <a name="input_is-production"></a> [is-production](#input\_is-production) | is this for production or non production | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to be used by all resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_record"></a> [cert\_record](#output\_cert\_record) | n/a |
<!-- END_TF_DOCS -->
