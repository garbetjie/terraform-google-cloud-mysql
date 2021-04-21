terraform {
  required_version = ">= 0.14"
  experiments = [module_variable_optional_attrs]

  required_providers {
    mysql = {
      source = "winebarrel/mysql"
    }
  }
}

provider mysql {
  endpoint = google_sql_database_instance.master.public_ip_address
  username = google_sql_user.terraform.name
  password = google_sql_user.terraform.password
}