data "azurerm_resource_group" "rg" {
  name = var.resource-group-name
}

locals {
  baseName = "${var.appName}-${var.environment}-cache-${var.location}"
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "redis" {
  name                = local.baseName
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = data.azurerm_resource_group.rg.tags
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = false
  minimum_tls_version = var.minimum_tls_version

  redis_configuration {
  }
}

resource "azurerm_redis_firewall_rule" "firewallRules" {
  count               = length(var.firewallRules)
  name                = var.firewallRules[count.index].name
  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = data.azurerm_resource_group.rg.name
  start_ip            = var.firewallRules[count.index].start_ip
  end_ip              = var.firewallRules[count.index].end_ip
}

# If you are looking at these alerts and thinking the severity is backwards
# Alaska Airlines calls Sev 1 Critical and Azure calls Sev 4 Critical
# These alerts are correct in their escalation

resource "azurerm_monitor_metric_alert" "memoryMonitoringSev2" {
  name                = "${local.baseName} Redis Memory Monitoring Sev2"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Metric alerts for a Redis Instance with high Memory Usage - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "UsedMemoryPercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = var.actionGroupId
  }
}

resource "azurerm_monitor_metric_alert" "memoryMonitoringSev3" {
  name                = "${local.baseName} Redis Memory Monitoring Sev3"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Metric alerts for a Redis Instance with high Memory Usage - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "UsedMemoryPercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 70
  }

  action {
    action_group_id = var.actionGroupId
  }
}

resource "azurerm_monitor_metric_alert" "memoryMonitoringSev4" {
  name                = "${local.baseName} Redis Memory Monitoring Sev4"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Metric alerts for a Redis Instance with high Memory Usage - Sev 4."
  severity            = 4

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "UsedMemoryPercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.actionGroupId
  }
}

resource "azurerm_monitor_metric_alert" "highProcessorSev2" {
  name                = "${local.baseName} Redis Processor Time Monitoring Sev2"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Metric alerts for a Redis Instance with high Processor Time Usage - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "PercentProcessorTime"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = var.actionGroupId
  }
}

resource "azurerm_monitor_metric_alert" "highProcessorSev3" {
  name                = "${local.baseName} Redis Processor Time Monitoring Sev3"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Metric alerts for a Redis Instance with high Processor Time Usage - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "PercentProcessorTime"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 70
  }

  action {
    action_group_id = var.actionGroupId
  }
}

resource "azurerm_monitor_metric_alert" "highProcessorSev4" {
  name                = "${local.baseName} Redis Processor Time Monitoring Sev4"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_redis_cache.redis.id]
  description         = "Metric alerts for a Redis Instance with high Processor Time Usage - Sev 4."
  severity            = 4

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "PercentProcessorTime"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.actionGroupId
  }
}

