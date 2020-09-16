output master_address {
  value = google_sql_database_instance.master.public_ip_address
}

output master_private_address {
  value = google_sql_database_instance.master.private_ip_address
}

output master_name {
  value = google_sql_database_instance.master.name
}

output flags {
  value = local.flags
}

output readonly_replica_address {
  value = length(google_sql_database_instance.read_replica) > 0 ? google_sql_database_instance.read_replica[0].public_ip_address : null
}

output readonly_replica_private_address {
  value = length(google_sql_database_instance.read_replica) > 0 ? google_sql_database_instance.read_replica[0].private_ip_address : null
}

output readonly_replica_name {
  value = length(google_sql_database_instance.read_replica) > 0 ? google_sql_database_instance.read_replica[0].name : null
}
