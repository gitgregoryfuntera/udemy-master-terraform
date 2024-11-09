output "example1" {
  value = startswith(lower(local.name), "john")
}

output "example2" {
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name
}

output "example3" {
  value = jsonencode(local.my_object)
}
