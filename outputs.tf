output "fqdn" {
  value = "${azurerm_mysql_server.server.fqdn}"
}

output "server_name" {
  value = "${var.server_name}"
}

output "db_name" {
  value = "${var.db_name}"
}

output "vault_mount" {
  value = "${vault_mount.db.path}"
}
