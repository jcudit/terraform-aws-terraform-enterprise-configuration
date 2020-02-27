package test

import (
	"context"
	"fmt"
	"math/rand"
	"os"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	tfe "github.com/hashicorp/go-tfe"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/dev-us-west-1
func TestPolicyCommon(t *testing.T) {
	t.Parallel()

	// Setup working directory for test runs
	exampleFolder = test_structure.CopyTerraformFolderToTemp(
		t,
		"../../",
		"examples/dev-us-west-1",
	)

	// Deploy the tested infrastructure
	test_structure.RunTestStage(t, "setup", func() {

		// Create a Terraform Enterprise Client
		ctx = context.Background()
		newClient, err := tfe.NewClient(&tfe.Config{
			Token:   os.Getenv("TFE_TOKEN"),
			Address: fmt.Sprintf("https://%s", os.Getenv("TFE_HOSTNAME")),
		})
		assert.NoError(t, err)
		tfeClient = newClient

		// Create a new organization
		organizationName = fmt.Sprintf("github-test-%s", randomString(6))
		options := tfe.OrganizationCreateOptions{
			Name:  tfe.String(organizationName),
			Email: tfe.String("admin@github.com"),
		}
		org, err := tfeClient.Organizations.Create(ctx, options)
		assert.NoError(t, err)
		assert.Equal(t, org.Name, organizationName)

		// Run `terraform init` and `terraform apply` and fail if there are errors
		terraform.InitAndApply(t, terraformOptions())
	})

	// Validate the test infrastructure
	test_structure.RunTestStage(t, "validate", func() {
		testPolicyCommonValid(t)
		testTeamsValid(t)
		testWorkspacesValid(t)
	})

	// At the end of the test, `terraform destroy` the created resources
	defer test_structure.RunTestStage(t, "teardown", func() {

		// Destroy created resources
		terraform.Destroy(t, terraformOptions())

		// Delete organization created by this test suite
		err := tfeClient.Organizations.Delete(ctx, organizationName)
		assert.NoError(t, err)
	})

}

func testPolicyCommonValid(t *testing.T) {

	// Run `terraform output` to get the value of an output variable
	enabledPoliciesCommon := terraform.Output(
		t, terraformOptions(), "enabled_policies_common",
	)

	// The enabled common policies have valid characteristics
	assert.NotEmpty(t, enabledPoliciesCommon)
	assert.Contains(t, enabledPoliciesCommon, "validate-all-variables-have-descriptions")

}

func testTeamsValid(t *testing.T) {

	// Run `terraform output` to get the value of an output variable
	teamNames := terraform.Output(
		t, terraformOptions(), "team_names",
	)

	// The enabled common policies have valid characteristics
	assert.NotEmpty(t, teamNames)
	assert.Contains(t, teamNames, "team_a")
	assert.Contains(t, teamNames, "team_b")
}

func testWorkspacesValid(t *testing.T) {

	// Run `terraform output` to get the value of an output variable
	workspaceIDs := terraform.Output(
		t, terraformOptions(), "workspace_ids",
	)

	// The enabled common policies have valid characteristics
	assert.Contains(t, workspaceIDs, "dev-us-west-1-aws-terraform-enterprise")
	assert.Contains(t, workspaceIDs, "stg-us-west-1-aws-terraform-enterprise")
	assert.Contains(t, workspaceIDs, "prd-us-west-1-aws-terraform-enterprise")

}

func randomString(n int) string {
	var letter = []rune("abcdefghijklmnopqrstuvwxyz")

	rand.Seed(time.Now().UTC().UnixNano())
	b := make([]rune, n)
	for i := range b {
		b[i] = letter[rand.Intn(len(letter))]
	}
	return string(b)
}

func terraformOptions() *terraform.Options {

	envVars := map[string]string{
		"AWS_DEFAULT_REGION": "us-west-1",
	}

	vars := map[string]interface{}{
		"environment":       "development",
		"region":            "us-west-1",
		"organization_name": organizationName,
	}

	if value, exists := os.LookupEnv("TFE_HOSTNAME"); exists {
		vars["hostname"] = value
	}

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: exampleFolder,

		// Variables are not passed to our Terraform code using -var options
		Vars: vars,

		// Environment variables to set when running Terraform
		EnvVars: envVars,
	}

	return terraformOptions
}

// Shared values
var exampleFolder string
var organizationName string
var tfeClient *tfe.Client
var ctx context.Context
