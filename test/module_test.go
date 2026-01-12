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

	// Test non-production module outputs
	nonProdCertificateDomain := terraform.Output(t, terraformOptions, "non_prod_certificate_domain")
	assert.Equal(t, "platforms-test.modernisation-platform.service.justice.gov.uk", nonProdCertificateDomain, "Non-prod certificate domain should match expected FQDN")

	nonProdCertificateArn := terraform.Output(t, terraformOptions, "non_prod_certificate_arn")
	assert.NotEmpty(t, nonProdCertificateArn, "Non-prod certificate ARN should not be empty")
	assert.True(t, strings.HasPrefix(nonProdCertificateArn, "arn:aws:acm:"), "Non-prod certificate ARN should start with 'arn:aws:acm:'")

	// Test dns_validation_records_core_vpc output (should have records for non-prod, null for prod)
	nonProdDnsValidationRecords := terraform.Output(t, terraformOptions, "non_prod_dns_validation_records")
	assert.NotEmpty(t, nonProdDnsValidationRecords, "DNS validation records for core-vpc should not be empty for non-production")

	// Test certificate_validation_non_prod output (should exist for non-prod)
	nonProdCertificateValidation := terraform.Output(t, terraformOptions, "non_prod_certificate_validation")
	assert.NotEmpty(t, nonProdCertificateValidation, "Certificate validation non-prod should not be empty for non-production")

	// Test production module outputs
	prodCertificateDomain := terraform.Output(t, terraformOptions, "prod_certificate_domain")
	assert.Equal(t, "testing-test.modernisation-platform.service.justice.gov.uk", prodCertificateDomain, "Prod certificate domain should match expected FQDN")

	prodCertificateArn := terraform.Output(t, terraformOptions, "prod_certificate_arn")
	assert.NotEmpty(t, prodCertificateArn, "Prod certificate ARN should not be empty")
	assert.True(t, strings.HasPrefix(prodCertificateArn, "arn:aws:acm:"), "Prod certificate ARN should start with 'arn:aws:acm:'")

	// Test dns_validation_records_core_network_services output (should have records for prod, null for non-prod)
	prodDnsValidationRecords := terraform.Output(t, terraformOptions, "prod_dns_validation_records")
	assert.NotEmpty(t, prodDnsValidationRecords, "DNS validation records for core-network-services should not be empty for production")

	// Test certificate_validation_prod output (should exist for prod)
	prodCertificateValidation := terraform.Output(t, terraformOptions, "prod_certificate_validation")
	assert.NotEmpty(t, prodCertificateValidation, "Certificate validation prod should not be empty for production")

}
