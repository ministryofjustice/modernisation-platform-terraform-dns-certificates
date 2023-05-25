# Modernisation Platform Terraform Module Template 

[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=blue&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.result&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fapi%2Fv1%2Fcompliant_public_repositories%2Fmodernisation-platform-terraform-module-template)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/public-github-repositories.html#modernisation-platform-terraform-module-template "Link to report")

## Usage

```hcl

module "template" {

  source = "github.com/ministryofjustice/modernisation-platform-terraform-module-template"

  tags             = local.tags
  application_name = local.application_name

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_var.aws_account_id"></a> [var.aws\_account\_id](#provider\_var.aws\_account\_id) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [var_aws_route53_record.www-dev](https://registry.terraform.io/providers/hashicorp/var/latest/docs/resources/aws_route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_needed"></a> [acm\_certificate\_needed](#input\_acm\_certificate\_needed) | Flag to determin if acm certificate if needed | `bool` | n/a | yes |
| <a name="input_alias_dns_name"></a> [alias\_dns\_name](#input\_alias\_dns\_name) | n/a | `string` | n/a | yes |
| <a name="input_alias_zone"></a> [alias\_zone](#input\_alias\_zone) | n/a | `string` | n/a | yes |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Name of application | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `any` | n/a | yes |
| <a name="input_certificate_body"></a> [certificate\_body](#input\_certificate\_body) | n/a | `string` | n/a | yes |
| <a name="input_certificate_chain"></a> [certificate\_chain](#input\_certificate\_chain) | Path to the certificate chain file | `any` | n/a | yes |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS name to be used with the zone | `string` | n/a | yes |
| <a name="input_gandi_certificate_needed"></a> [gandi\_certificate\_needed](#input\_gandi\_certificate\_needed) | Flag to determin if gandi certificate is needed | `bool` | n/a | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Path to the private key file | `any` | n/a | yes |
| <a name="input_record"></a> [record](#input\_record) | A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM | `string` | n/a | yes |
| <a name="input_record_type"></a> [record\_type](#input\_record\_type) | type of record to create | `string` | `"CNAME"` | no |
| <a name="input_set_identifier"></a> [set\_identifier](#input\_set\_identifier) | Unique identifier to differentiate records with routing policies from one another. | `string` | n/a | yes |
| <a name="input_ssm_private_key"></a> [ssm\_private\_key](#input\_ssm\_private\_key) | cert key from aws parameter store or secrets manager | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to be used by all resources | `map(string)` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
