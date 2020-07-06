package test

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/services/redis/mgmt/2018-03-01/redis"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"github.com/tsalright/terratest/modules/azure"
)

const (
	// AzureSubscriptionID is an optional env variable supported by the `azurerm` Terraform provider to
	// designate a target Azure subscription ID
	AzureSubscriptionID = "ARM_SUBSCRIPTION_ID"

	// AzureResGroupName is an optional env variable custom to Terratest to designate a target Azure resource group
	AzureResGroupName = "tfmodulevalidation-test-group"
)

type RedisValidationArgs struct {
	appName          string
	capacity         int32
	family           redis.SkuFamily
	skuName          redis.SkuName
	firewallRuleName string
	firewallStartIP  string
	firewallEndIP    string
}

func TestRedisFirewallExample(t *testing.T) {
	// Arrange
	terraformOptions := &terraform.Options{
		TerraformDir: "../example/redis-firewall/.",
	}

	expectedRedisArgs := RedisValidationArgs{
		appName:          "redisFirewall1-test-cache-westus2",
		capacity:         1,
		family:           redis.C,
		skuName:          redis.Basic,
		firewallRuleName: "Test",
		firewallStartIP:  "1.1.1.1",
		firewallEndIP:    "1.1.1.2",
	}

	defer terraform.Destroy(t, terraformOptions)

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Assert
	validateRedis(t, terraformOptions, &expectedRedisArgs)
}

func TestRedisNoFirewallExample(t *testing.T) {
	// Arrange
	terraformOptions := &terraform.Options{
		TerraformDir: "../example/redis-nofirewall/.",
	}

	expectedRedisArgs := RedisValidationArgs{
		appName:  "redisNoFirewall1-test-cache-westus2",
		capacity: 1,
		family:   redis.C,
		skuName:  redis.Basic,
	}

	defer terraform.Destroy(t, terraformOptions)

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Assert
	validateRedis(t, terraformOptions, &expectedRedisArgs)
}

func validateRedis(t *testing.T, terraformOptions *terraform.Options, args *RedisValidationArgs) {
	assert := assert.New(t)

	primaryConnectionString := terraform.Output(t, terraformOptions, "primary_connection_string")
	assert.NotNil(primaryConnectionString)

	secondaryConnectionString := terraform.Output(t, terraformOptions, "secondary_connection_string")
	assert.NotNil(secondaryConnectionString)

	id := terraform.Output(t, terraformOptions, "id")
	assert.NotNil(id)

	r := GetRedis(t, args.appName)

	assert.Equal(args.capacity, *r.Sku.Capacity)
	assert.Equal(args.family, r.Sku.Family)
	assert.Equal(args.skuName, r.Sku.Name)

	if args.firewallRuleName != "" {
		rFirewallRule := GetRedisFirewall(t, args.appName, args.firewallRuleName)
		assert.Equal(args.appName+"/"+args.firewallRuleName, *rFirewallRule.Name)
		assert.Equal(args.firewallStartIP, *rFirewallRule.FirewallRuleProperties.StartIP)
		assert.Equal(args.firewallEndIP, *rFirewallRule.FirewallRuleProperties.EndIP)
	}
}

func GetRedis(t *testing.T, name string) *redis.ResourceType {
	plan, err := getRedisE(name)
	require.NoError(t, err)

	return plan
}

func getRedisE(name string) (*redis.ResourceType, error) {
	client, err := getRedisClient()
	if err != nil {
		return nil, err
	}

	plan, err := client.Get(context.Background(), AzureResGroupName, name)
	if err != nil {
		return nil, err
	}

	return &plan, nil
}

func getRedisClient() (*redis.Client, error) {
	subID := os.Getenv(AzureSubscriptionID)

	// Create an AppServicePlanClient
	client := redis.NewClient(subID)

	authorizer, err := azure.NewAuthorizer()
	if err != nil {
		return nil, err
	}

	client.Authorizer = *authorizer

	return &client, nil
}

func GetRedisFirewall(t *testing.T, redisName, name string) *redis.FirewallRule {
	plan, err := getRedisFirewallE(redisName, name)
	require.NoError(t, err)

	return plan
}

func getRedisFirewallE(redisName, name string) (*redis.FirewallRule, error) {
	client, err := getRedisFirewallClient()
	if err != nil {
		return nil, err
	}

	plan, err := client.Get(context.Background(), AzureResGroupName, redisName, name)
	if err != nil {
		return nil, err
	}

	return &plan, nil
}

func getRedisFirewallClient() (*redis.FirewallRulesClient, error) {
	subID := os.Getenv(AzureSubscriptionID)

	// Create an AppServicePlanClient
	client := redis.NewFirewallRulesClient(subID)

	authorizer, err := azure.NewAuthorizer()
	if err != nil {
		return nil, err
	}

	client.Authorizer = *authorizer

	return &client, nil
}
