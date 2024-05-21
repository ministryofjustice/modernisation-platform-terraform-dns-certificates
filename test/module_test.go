package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCertificateCreation(t *testing.T) {
	t.Parallel()

	terraformDir := "./unit-test"

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

}
