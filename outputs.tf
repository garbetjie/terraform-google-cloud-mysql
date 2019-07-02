output "public_ip_address" {
  value = var.networking_public_ip_enabled ? google_sql_database_instance.master.public_ip_address : null
}

output "private_ip_address" {
  value = var.networking_private_ip_network != null ? google_sql_database_instance.master.private_ip_address : null
}
