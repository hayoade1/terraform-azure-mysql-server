provider vault{
  }

resource "vault_generic_secret" "scalability" {
  path = "kv/secret/scalability"

  data_json = <<EOT
{
  "username":   random_string.username.result,
  "password": random_string.password.result
}
EOT
 
}

