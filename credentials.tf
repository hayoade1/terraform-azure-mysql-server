resource "random_string" "username" {
  length  = 24
  special = false
}

resource "random_string" "password" {
  length  = 24
  special = true
}
