variable "name" {
  type = string
  description = "Name of the Cloud SQL instance."
}

variable "name_suffix_length" {
  type = number
  default = 3
  description = "Bytes of random data to generate to append to the name of the instance. Used to prevent name clashes (hex encoded, so length will be 2x number specified here)."
}

variable "region" {
  type = string
  description = "Region in which the Cloud SQL instance should reside."
}

variable "database_version" {
  type = string
  default = "MYSQL_5_7"
  description = "Database's version of MySQL."
}

variable "tier" {
  type = string
  default = "db-f1-micro"
  description = "Size of the database."
}

variable "disk_autoresize" {
  type = bool
  default = true
  description = "Automatically grow the size of the instance's disk."
}

variable "disk_size" {
  type = number
  default = 10
  description = "Size of the disk in GB."
}

variable "disk_type" {
  type = string
  default = "PD_HDD"
  description = "Type of disk (must be one of PD_SSD or PD_HDD)."
}

variable "database_flags" {
  type = map
  default = {
    character_set_server = "utf8mb4",
    query_cache_type = 0,
    query_cache_size = 0,
    default_time_zone = "+00:00",
    event_scheduler = true,
    innodb_file_per_table = true,
  }
  description = "Additional MySQL flags to configure on the database."
}

variable "labels" {
  type = map
  default = {}
  description = "Labels to apply to the instance."
}

variable "backups_enabled" {
  type = bool
  default = true
  description = "Enable backups"
}

variable "backup_start_time" {
  type = "string"
  default = "00:00"
  description = "The start of the 4 hour backup window (specified in UTC)."
}

variable "networking_public_ip_enabled" {
  type = bool
  default = false
  description = "Assign a public IP to this instance."
}

variable "networking_private_ip_network" {
  type = string
  default = null
  description = "selfLink of network in which to assign a private IP address to this instance."
}

variable "networking_authorized_networks" {
  type = list(object({ name = string, cidr = string }))
  default = []
  description = "CIDR notations of networks allowed access to the public IP address."
}
