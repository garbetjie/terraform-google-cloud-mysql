resource random_password user_passwords {
  for_each = local.users
  length = 16
  override_special = "_-.,@!"
  min_special = 1
  min_lower = 1
  min_upper = 1
  min_numeric = 1
  keepers = {
    username = each.value.username
    host = each.value.host
  }
}

resource random_password terraform {
  length = lookup(local.user_password_lengths, "terraform@%", 40)
  min_special = 3
  min_lower = 3
  min_upper = 3
  min_numeric = 3
  keepers = {
    username = "terraform"
    host = "%"
  }
}

resource google_sql_user terraform {
  instance = google_sql_database_instance.master.name
  name = random_password.terraform.keepers.username
  host = random_password.terraform.keepers.host
  password = random_password.terraform.result
}

resource mysql_user users {
  for_each = local.users
  user = each.value.username
  plaintext_password = each.value.password == "" ? random_password.user_passwords[each.key].result : each.value.password
  host = each.value.host
}

resource mysql_grant user_grants {
  for_each = local.grants
  user = each.value.user
  host = each.value.host
  database = each.value.database
  privileges = each.value.privileges

  depends_on = [mysql_user.users]
}
