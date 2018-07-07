output "fqdn" {
  value = "${azurerm_mysql_server.server.fqdn}"
}

output "server_name" {
  value = "${var.server_name}"
}

output "db_name" {
  value = "${var.db_name}"
}

output "vault_token" {
  value = "${var.vault_token}"
}

output "vault_cluster" {
  value = "${var.vault_cluster}"
}
