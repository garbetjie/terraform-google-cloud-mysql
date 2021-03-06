variable name {
  type = string
  description = "Name of the Cloud SQL instance."
}

variable region {
  type = string
  description = "Region in which the Cloud SQL instance should reside."
}

variable database_version {
  type = string
  default = "MYSQL_8_0"
  description = "Database's version of MySQL."
}

variable tier {
  type = string
  default = "db-f1-micro"
  description = "Size of the database."
}

variable disk_autoresize {
  type = bool
  default = true
  description = "Automatically grow the size of the instance's disk."
}

variable disk_size {
  type = number
  default = 10
  description = "Size of the disk in GB."
}

variable disk_type {
  type = string
  default = "PD_HDD"
  description = "Type of disk (must be one of PD_SSD or PD_HDD)."
}

variable default_flags {
  type = map(string)
  default = {
    character_set_server = "utf8mb4",
    query_cache_type = "0",
    query_cache_size = "0",
    default_time_zone = "+00:00",
    event_scheduler = "on",
    innodb_file_per_table = "on",
  }
  description = "Default map of database flags that are merged with the flags variable."
}

variable flags {
  type = map(string)
  default = {}
}

variable labels {
  type = map(string)
  default = {}
  description = "Labels to apply to the instance."
}

variable backups_enabled {
  type = bool
  default = true
  description = "Enable backups"
}

variable backup_start_time {
  type = string
  default = "00:00"
  description = "The start of the 4 hour backup window (specified in UTC)."
}

variable ipv4_enabled {
  type = bool
  default = true
  description = "Assign a public IP to this instance."
}

variable private_network_link {
  type = string
  default = null
  description = "self_link of network in which to assign a private IP address to this instance."
}

variable authorized_networks {
  type = list(string)
  default = []
  description = "CIDR notations of networks allowed access to the public IP address."
}

variable enable_read_replica {
  type = bool
  default = false
  description = "Enable creation of a read-only replica of the master."
}

variable read_replica_name_suffix {
  type = string
  default = "-readonly"
}

variable enable_high_availability {
  type = bool
  default = false
}

variable databases {
  type = list(string)
  default = []
}

variable name_suffix_type {
  type = string
  default = "id"
}

//variable users {
//  type = list(object({
//    username = string
//    password = optional(string)
//    host = optional(string)
//    privileges = optional(map(list(string)))
//  }))
//  default = []
//}

variable add_name_suffix {
  type = bool
  default = true
  description = "If true, adds a suffix to the name of all instances, to prevent name collisions."
}

