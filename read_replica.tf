resource "google_sql_database_instance" "read_replica" {
  count = var.enable_read_replica ? 1 : 0
  name = "${google_sql_database_instance.master.name}${var.read_replica_name_suffix}"
  region = var.region
  database_version = var.database_version
  master_instance_name = google_sql_database_instance.master.name

  settings {
    disk_autoresize = var.disk_autoresize
    disk_size = var.disk_size
    disk_type = var.disk_type
    tier = var.tier
    user_labels = var.labels
    activation_policy = "ALWAYS"

    dynamic "database_flags" {
      for_each = local.flags

      content {
        name = database_flags.key
        value = database_flags.value
      }
    }

    // No backup required, as we're the readonly replica..
    backup_configuration {
      binary_log_enabled = false
      enabled = false
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
      day = 2
      hour = 1
      update_track = "stable"
    }
  }

  replica_configuration {
    connect_retry_interval = 30
    failover_target = false
  }
}
