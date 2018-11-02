resource "azurerm_mysql_server" "server" {
  name                = "${var.server_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  sku {
    name     = "B_Gen4_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen4"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "${random_string.username.result}"
  administrator_login_password = "${random_string.password.result}"
  version                      = "5.7"
  ssl_enforcement              = "Disabled"
}

resource "azurerm_mysql_database" "db" {
  name                = "${var.db_name}"
  resource_group_name = "${var.resource_group}"
  server_name         = "${azurerm_mysql_server.server.name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "fw_rule_vault" {
  name                = "${var.service_name}-${var.server_name}-vault"
  resource_group_name = "${var.resource_group}"
  server_name         = "${azurerm_mysql_server.server.name}"
  start_ip_address    = "${element(split(":", element(split("//", var.vault_addr), 1)), 0)}"
  end_ip_address      = "${element(split(":", element(split("//", var.vault_addr), 1)), 0)}"
}
