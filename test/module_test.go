package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCertificateCreation(t *testing.T) {
	t.Parallel()

	terraformDir := "./unit-test"

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Test certificate_domain output
	certificateDomain := terraform.Output(t, terraformOptions, "certificate_domain")
	assert.Equal(t, "platforms-test.modernisation-platform.service.justice.gov.uk", certificateDomain, "Certificate domain should match expected FQDN")

	// Test certificate_arn output
	certificateArn := terraform.Output(t, terraformOptions, "certificate_arn")
	assert.NotEmpty(t, certificateArn, "Certificate ARN should not be empty")
	assert.True(t, strings.HasPrefix(certificateArn, "arn:aws:acm:"), "Certificate ARN should start with 'arn:aws:acm:'")

	// Test certificate_id output
	certificateId := terraform.Output(t, terraformOptions, "certificate_id")
	assert.NotEmpty(t, certificateId, "Certificate ID should not be empty")

	// Test certificate_domain_validation_options output
	domainValidationOptions := terraform.Output(t, terraformOptions, "certificate_domain_validation_options")
	assert.NotEmpty(t, domainValidationOptions, "Certificate domain validation options should not be empty")

	// Test dns_validation_records_core_vpc output (should have records for non-prod)
	dnsValidationRecordsCoreVpc := terraform.Output(t, terraformOptions, "dns_validation_records_core_vpc")
	assert.NotEmpty(t, dnsValidationRecordsCoreVpc, "DNS validation records for core-vpc should not be empty for non-production")

	// Test certificate_validation_non_prod output (should exist for non-prod)
	certificateValidationNonProd := terraform.Output(t, terraformOptions, "certificate_validation_non_prod")
	assert.NotEmpty(t, certificateValidationNonProd, "Certificate validation non-prod should not be empty for non-production")

}
