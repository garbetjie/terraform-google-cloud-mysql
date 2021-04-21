locals {
  flags = {
    for key, value in merge(var.default_flags, var.flags):
      key => value
    if !contains(lookup(local.disallowed_flags, var.database_version, []), key)
  }

  disallowed_flags = {
    MYSQL_8_0 = ["query_cache_size", "query_cache_type"]
  }

  instance_name_suffix = var.add_name_suffix ? (lower(var.name_suffix_type) == "string" ? random_string.master_suffix.result : random_id.name_suffix.hex) : ""

  authorized_networks = {
    for network in var.authorized_networks:
      split(":", network)[0] => {
        cidr = split(":", network)[0]
        name = length(split(":", network)) >= 2 ? split(":", network)[1] : format("terraform-managed-%s", substr(sha1(split(":", network)[0]), 0, 4))
      }
  }

  databases = {
    for db in var.databases:
      db => {
        collation = "utf8mb4_unicode_ci"
        charset = "utf8mb4"
      }
  }

//  users = {
//    for user in var.users:
//      format("%s@%s", user.username, user.host == null ? "%" : user.host) => {
//        username = user.username
//        password = user.password == null ? "" : user.password
//        host = user.host == null ? "%" : user.host
//        privileges = length(user.privileges == null ? {} : user.privileges) == 0 ? map("*", ["ALL"]) : user.privileges
//      }
//  }
//
//  _grants = flatten([
//    for user in local.users: [
//      for database, privileges in user.privileges: {
//        database = database
//        privileges = privileges
//        user = user.username
//        host = user.host
//      }
//    ]
//  ])
//
//  grants = {
//    for grant in local._grants:
//      format("%s@%s:%s", grant.user, grant.host, grant.database) => grant
//  }
//
//  user_password_lengths = {
//    "terraform@%" = 40
//  }
}
