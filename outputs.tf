output master_address {
  value = google_sql_database_instance.master.public_ip_address
}

output master_self_link {
  value = google_sql_database_instance.master.self_link
}

output master_private_address {
  value = google_sql_database_instance.master.private_ip_address
}

output master_name {
  value = google_sql_database_instance.master.name
}

output master_connection_name {
  value = google_sql_database_instance.master.connection_name
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

output readonly_replica_self_link {
  value = length(google_sql_database_instance.read_replica) > 0 ? google_sql_database_instance.read_replica[0].self_link : null
}

output readonly_replica_connection_name {
  value = length(google_sql_database_instance.read_replica) > 0 ? google_sql_database_instance.read_replica[0].connection_name : null
}

//output users {
//  // We need to do it like this because as per https://www.terraform.io/docs/providers/mysql/r/user.html, the password
//  // is salted before being stored in the state.
//  value = [
//    for user in mysql_user.users: {
//      host = user.host
//      username = user.user
//      password = (local.users[format("%s@%s", user.user, user.host)].password == ""
//        ? random_password.user_passwords[format("%s@%s", user.user, user.host)].result
//        : local.users[format("%s@%s", user.user, user.host)].password)
//    }
//  ]
//}
