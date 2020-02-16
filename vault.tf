
resource "vault_generic_secret" "scalability" {
  count = 2
  path = "kv/secret/scalability${count.index}"

  data_json = <<EOT
{
  "username":   "${random_string.username.result.count.index}",
  "password": "${random_string.password.result.count.index}"
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

