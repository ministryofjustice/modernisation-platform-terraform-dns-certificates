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

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
