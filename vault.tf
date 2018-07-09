data "template_file" "credentials" {
  template = "${file("${path.module}/vault_credentials.json.tpl")}"

  vars {
    username = "${random_string.username.result}"
    password = "${random_string.password.result}"
  }
}

resource "vault_generic_secret" "credentials" {
  path      = "secret/database/${var.server_name}/${var.db_name}/credentials"
  data_json = "${data.template_file.credentials.rendered}"
}

resource "vault_mount" "db" {
  path = "db-${var.server_name}"
  type = "database"
}

data "template_file" "vault_backend_connection" {
  template = "${file("${path.module}/database_connection.json.tpl")}"

  vars = {
    db_host        = "${azurerm_mysql_server.server.fqdn}"
    db_port        = 3306
    db_name        = "${var.db_name}"
    username       = "${random_string.username.result}"
    password       = "${random_string.password.result}"
    db_server_name = "${var.server_name}"
  }
}

#resource "vault_generic_secret" "MySQLConnection" {
#  path      = "db-${data.terraform_remote_state.db.server_name}/config/${data.terraform_remote_state.db.db_name}"
#  data_json = "${data.template_file.vault_backend_connection.rendered}"
#}

resource "vault_database_secret_backend_connection" "mysql" {
  backend       = "${vault_mount.db.path}"
  name          = "${var.db_name}"
  allowed_roles = ["mysql_admin", "mysql_ro"]

  depends_on = [
    "azurerm_mysql_firewall_rule.fw_rule_vault",
  ]

  mysql {
    connection_url = "${random_string.username.result}@${var.server_name}:${random_string.password.result}@tcp(${azurerm_mysql_server.server.fqdn}:3306)/${var.db_name}"
  }
}

resource "vault_database_secret_backend_role" "mysql_admin" {
  backend             = "${vault_mount.db.path}"
  name                = "mysql_crud"
  db_name             = "${var.db_name}"
  creation_statements = "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}'; grant SELECT,INSERT,UPDATE,DELETE on ${var.db_name}.* to '{{name}}'@'%'"
}

resource "vault_database_secret_backend_role" "mysql_ro" {
  backend             = "${vault_mount.db.path}"
  name                = "mysql_ro"
  db_name             = "${var.db_name}"
  creation_statements = "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}'; grant SELECT on ${var.db_name}.* to '{{name}}'@'%'"
}

# CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';

data "template_file" "mysql_ro" {
  template = "${file("${path.module}/vault_policy_templates/mysql_ro.hcl.tpl")}"

  vars {
    db_name = "${var.db_name}"
  }
}

resource "vault_policy" "mysql_ro" {
  name   = "${var.db_name}-mysql_ro"
  policy = "${data.template_file.mysql_ro.rendered}"
}

data "template_file" "mysql_crud" {
  template = "${file("${path.module}/vault_policy_templates/mysql_crud.hcl.tpl")}"

  vars {
    db_name = "${var.db_name}"
  }
}

resource "vault_policy" "mysql_crud" {
  name   = "${var.db_name}-mysql_crud"
  policy = "${data.template_file.mysql_ro.rendered}"
}
