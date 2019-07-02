output "master_public_ip_address" {
  value = var.networking_public_ip_enabled ? google_sql_database_instance.master.public_ip_address : null
}

output "master_private_ip_address" {
  value = var.networking_private_ip_network != null ? google_sql_database_instance.master.private_ip_address : null
}

output "replica_public_ip_address" {
  value = length(google_sql_database_instance.replica) > 0 ? google_sql_database_instance.replica[0].public_ip_address : null
}

output "replica_private_ip_address" {
  value = length(google_sql_database_instance.replica) > 0 ? google_sql_database_instance.replica[0].private_ip_address : null
}
