resource "random_string" "username" {
  length  = 16
  special = false
  number  = false
  upper   = false
  count = 2
}

resource "random_string" "password" {
  length  = 16
  special = false
  count = 2
}
