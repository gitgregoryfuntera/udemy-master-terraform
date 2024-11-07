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

locals {
  firstnames_from_splat        = var.object_list[*].firstname
  roles_from_splat             = [for username, user_props in local.users_map2 : user_props.roles]
  roles_from_splat_with_values = values(local.users_map2)[*].roles
}


output "splat" {
  value = {
    firstnames_from_splat        = local.firstnames_from_splat
    roles_from_splat             = local.roles_from_splat
    roles_from_splat_with_values = local.roles_from_splat_with_values
  }
}
