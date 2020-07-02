output "primary_connection_string" {
  value       = "${azurerm_redis_cache.redis.primary_connection_string}"
  description = "The primary connection string of the Redis Instance."
}

output "secondary_connection_string" {
  value       = "${azurerm_redis_cache.redis.secondary_connection_string}"
  description = "The secondary connection string of the Redis Instance."
}

output "id" {
  value       = "${azurerm_redis_cache.redis.id}"
  description = "The Route ID."
}