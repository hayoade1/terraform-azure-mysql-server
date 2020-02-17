provider vault{
  }
count = 2
resource "vault_generic_secret" "scalability" {
  path = "kv/secret/scalability${count.index}"

  data_json = <<EOT
{
  "username":   random_string.username.result[count.index],
  "password": random_string.password.result[count.index]
}
EOT
 
}

