variable "client_id" {}

variable "client_secret" {}

variable "subscription_id" {}

variable "tenant_id" {}

variable "service_name" {
    default = "nextgen"
  }

variable "db_name" {
  default = "nextgeniam"
  }

variable "resource_group" {
  default = "nextgenresource"
  }

variable "server_name" {
  default = "nextgeniamserver"
  }

variable "location" {
  default = "East US"
  }

variable "max_ttl" {
  default = "90"
}

variable "default_ttl" {
  default = "30"
}

variable "vault_addr" {}
variable "vault_token" {}
variable "vault_cluster" {}
