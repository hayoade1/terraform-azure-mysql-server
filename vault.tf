
resource "vault_generic_secret" "scalability" {
  path = "scalability/secrets"

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
path "scalability/secrets" {
  policy = "read"
}
EOT
}

