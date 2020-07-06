resource-group-name = "tfmodulevalidation-test-group"
appName             = "redisFirewall"
environment         = "test"
location            = "westus2"
capacity            = 1
family              = "C"
sku_name            = "Basic"
firewallRules = [
  {
    name     = "Test"
    start_ip = "1.1.1.1"
    end_ip   = "1.1.1.2"
  }
]