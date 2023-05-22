package main

import (
	"testing"

	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestModule(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	exampleName := terraform.Output(t, terraformOptions, "example_name")

	assert.Regexp(t, regexp.MustCompile(`^example-name*`), exampleName)
}

//  package test

//  import (
//  	"testing"

//  	"github.com/aws/aws-sdk-go/aws/session"
//  	"github.com/gruntwork-io/terratest/modules/aws"
//  	"github.com/gruntwork-io/terratest/modules/random"
//  	"github.com/gruntwork-io/terratest/modules/terraform"
//  	"github.com/stretchr/testify/assert"
//  )

// func TestCreateRoute53Record(t *testing.T) {
// 	t.Parallel()

// 	// Generate a random name for the Route53 record
// 	recordName := "example.com" + random.UniqueId()

// 	// Specify the Route53 zone ID for which the record needs to be created
// 	zoneID := "YOUR_ROUTE53_ZONE_ID"

// 	// Specify the record type, such as A, CNAME, etc.
// 	recordType := "A"

// 	// Specify the record value
// 	recordValue := "10.0.0.1"

// 	// Specify the Terraform directory containing the Route53 resource definition
// 	terraformDir := "./unit-test"

// 	// Configure Terraform options with the environment variables
// 	terraformOptions := &terraform.Options{
// 		TerraformDir: terraformDir,
// 		Vars: map[string]interface{}{
// 			"record_name":  recordName,
// 			"zone_id":      zoneID,
// 			"record_type":  recordType,
// 			"record_value": recordValue,
// 		},
// 	}

// 	// Ensure Terraform resources are destroyed at the end of the test
// 	defer terraform.Destroy(t, terraformOptions)

// 	// Deploy the Terraform resources
// 	terraform.InitAndApply(t, terraformOptions)

// 	// Get the AWS session
// 	awsSession := session.Must(session.NewSessionWithOptions(session.Options{
// 		SharedConfigState: session.SharedConfigEnable,
// 	}))

// 	// Get the Route53 record
// 	record, err := aws.GetRoute53RecordSetE(t, awsSession, zoneID, recordName, recordType)
// 	assert.NoError(t, err)

// 	// Assert that the record exists
// 	assert.NotNil(t, record)
// 	assert.Equal(t, recordName, record.Name)
// 	assert.Equal(t, recordType, record.Type)
// 	assert.Equal(t, recordValue, record.Value)
// }
