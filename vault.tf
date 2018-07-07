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
