resource random_id name_suffix {
  byte_length = var.name_suffix_length
}

resource google_sql_database_instance master {
  name = format("%s-%s", var.name, random_id.name_suffix.hex)
  region = var.region
  database_version = var.database_version

  settings {
    disk_autoresize = var.disk_autoresize
    disk_size = var.disk_size
    disk_type = var.disk_type
    tier = var.tier
    user_labels = var.labels

    dynamic "database_flags" {
      for_each = var.database_flags

      content {
        name = database_flags.key
        value = database_flags.value
      }
    }

    backup_configuration {
      binary_log_enabled = true
      enabled = var.backups_enabled
      start_time = var.backup_start_time
    }

    ip_configuration {
      ipv4_enabled = var.networking_public_ip_enabled
      private_network = var.networking_private_ip_network

      dynamic "authorized_networks" {
        for_each = var.networking_authorized_networks

        content {
          name = authorized_networks.value.name
          value = authorized_networks.value.cidr
        }
      }
    }

    maintenance_window {
      day = 7
      hour = 1
      update_track = "stable"
    }
  }

  timeouts {
    create = var.networking_private_ip_network != null ? "15m" : "10m"
  }
}
