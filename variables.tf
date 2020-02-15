variable "client_id" {}

variable "client_secret" {}

variable "subscription_id" {}

variable "tenant_id" {}

variable "service_name" {
    default = "NextGen"
  }

variable "db_name" {
  default = "NextGenIAM"
  }

variable "resource_group" {
  default = "NextGen"
  }

variable "server_name" {
  default = "NextGenIAMDB"
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
