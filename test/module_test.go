package test

import (
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/route53"
	"github.com/aws/aws-sdk-go/service/sts"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCertificateCreation(t *testing.T) {
	t.Parallel()

	fqdn := "modernisation-platform.service.justice.gov.uk"
	recordType := "CNAME"
	terraformDir := "./unit-test"

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"fqdn":        fqdn,
			"record_type": recordType,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	awsSession, err := session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	})
	assert.NoError(t, err)

	// Get the AWS account ID
	stsClient := sts.New(awsSession)
	callerIdentity, err := stsClient.GetCallerIdentity(&sts.GetCallerIdentityInput{})
	assert.NoError(t, err)
	accountID := *callerIdentity.Account

	// Find the hosted zone ID for the given domain
	zoneID, err := getHostedZoneID(awsSession, accountID, fqdn)
	assert.NoError(t, err)

	// Retrieve the CNAME record created by Terraform
	record, err := getRoute53RecordSet(awsSession, zoneID, fqdn, recordType)
	assert.NoError(t, err)

	assert.NotNil(t, record)
	assert.Equal(t, fqdn, *record.Name)
	assert.Equal(t, recordType, *record.Type)

	// Assert the record value (CNAME target) matches the expected value
	expectedRecordValue := "_abc123.acm-validations.aws."
	assert.Equal(t, expectedRecordValue, *record.ResourceRecords[0].Value)
}

func getHostedZoneID(awsSession *session.Session, accountID, fqdn string) (string, error) {
	route53Client := route53.New(awsSession)

	hostedZones, err := route53Client.ListHostedZonesByName(&route53.ListHostedZonesByNameInput{
		DNSName: aws.String(fqdn),
	})
	if err != nil {
		return "", err
	}

	for _, hostedZone := range hostedZones.HostedZones {
		if strings.HasSuffix(*hostedZone.Name, fqdn+".") &&
			*hostedZone.Config.PrivateZone == false &&
			*hostedZone.Id != "/hostedzone/"+accountID {
			return strings.TrimPrefix(*hostedZone.Id, "/hostedzone/"), nil
		}
	}

	return "", nil
}

func getRoute53RecordSet(awsSession *session.Session, zoneID, fqdn, recordType string) (*route53.ResourceRecordSet, error) {
	route53Client := route53.New(awsSession)

	recordSet, err := route53Client.ListResourceRecordSets(&route53.ListResourceRecordSetsInput{
		HostedZoneId:    aws.String(zoneID),
		StartRecordName: aws.String(fqdn),
		StartRecordType: aws.String(recordType),
	})
	if err != nil {
		return nil, err
	}

	if len(recordSet.ResourceRecordSets) > 0 {
		return recordSet.ResourceRecordSets[0], nil
	}

	return nil, nil
}
