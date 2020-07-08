output "primary_connection_string" {
  value       = "${module.redis.primary_connection_string}"
  description = "The primary connection string of the Redis Instance."
}

output "secondary_connection_string" {
  value       = "${module.redis.secondary_connection_string}"
  description = "The secondary connection string of the Redis Instance."
}

output "id" {
  value       = "${module.redis.id}"
  description = "The Route ID."
}