resource "vault_generic_secret" "example" {
  path = "kv/secret/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}
