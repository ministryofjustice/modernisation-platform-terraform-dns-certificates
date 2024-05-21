package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCertificateCreation(t *testing.T) {
	t.Parallel()

	fqdn := "platforms-test.modernisation-platform.service.justice.gov.uk"
	terraformDir := "./unit-test"
	// environment := "test"
	production := "false"

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"fqdn":          fqdn,
			"is-production": production,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

}
