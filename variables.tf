variable "service_name" {}

variable "vault_token" {}

variable "vault_cluster" {}

variable "db_name" {}

variable "resource_group" {}

variable "server_name" {}

variable "location" {}

variable "max_ttl" {
  default = "90"
}

variable "default_ttl" {
  default = "30"
}
