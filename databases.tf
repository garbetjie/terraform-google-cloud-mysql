resource google_sql_database databases {
  for_each = local.databases
  name = each.key
  instance = google_sql_database_instance.master.name
  charset = each.value.charset
  collation = each.value.collation
}
