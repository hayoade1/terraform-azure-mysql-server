
resource "vault_generic_secret" "scalability" {
  path = "kv/secret/scalability"

  data_json = <<EOT
{
  "username":   "${random_string.username.result}",
  "password": "${random_string.password.result}"
}
EOT
}

resource "vault_policy" "scalability" {
  name = "dev-team"

  policy = <<EOT
path "secret/scalability" {
  policy = "read"
}
EOT
}

