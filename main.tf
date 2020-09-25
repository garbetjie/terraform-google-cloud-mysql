resource random_id name_suffix {
  byte_length = 2
  keepers = {
    name = var.name
    region = var.region
    database_version = var.database_version
  }
}

resource random_string master_suffix {
  length = 4
  special = false
  upper = false
}

resource google_sql_database_instance master {
  name = "${var.name}-${lower(var.name_suffix_type) == "string" ? random_string.master_suffix.result : random_id.name_suffix.hex}"
  region = var.region
  database_version = var.database_version

  settings {
    disk_autoresize = var.disk_autoresize
    disk_size = var.disk_size
    disk_type = var.disk_type
    tier = var.tier
    user_labels = var.labels
    activation_policy = "ALWAYS"
    availability_type = var.enable_high_availability ? "REGIONAL" : "ZONAL"

    dynamic "database_flags" {
      for_each = local.flags

      content {
        name = database_flags.key
        value = database_flags.value
      }
    }

    backup_configuration {
      binary_log_enabled = var.enable_high_availability || var.enable_read_replica ? true : var.backups_enabled
      enabled = var.enable_high_availability || var.enable_read_replica ? true : var.backups_enabled
      start_time = var.backup_start_time
    }

    ip_configuration {
      ipv4_enabled = var.ipv4_enabled
      private_network = var.private_network_link

      dynamic "authorized_networks" {
        for_each = local.authorized_networks

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
    create = var.private_network_link != null ? "15m" : "10m"
  }
}
