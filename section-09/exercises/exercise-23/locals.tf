locals {
  users_map = { for value in var.users : value.username => value.role... }
}

locals {
  users_map2 = {
    for username, roles in local.users_map : username => {
      roles = roles
    }
  }
}

output "local_outputs" {
  value = {
    users_map             = local.users_map
    users_map2            = local.users_map2
    users_to_output_roles = local.users_map2[var.users_to_output].roles
    usersnames_from_map   = [for username, roles in local.users_map : username]
    # We can also use usernames_from_map = keys(local.users_map) instead of manually creating the list!
  }
}
