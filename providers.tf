provider mysql {
  endpoint = google_sql_database_instance.master.public_ip_address
  username = google_sql_user.terraform.name
  password = google_sql_user.terraform.password
}
