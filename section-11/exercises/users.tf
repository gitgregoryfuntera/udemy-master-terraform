locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml")).users
  users_map = {
    for user_config in local.users_from_yaml : user_config.username => user_config.roles
  }
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml[*].username)
  name     = each.value

  tags = {
    ManageBy = "terraform"
  }
}

resource "aws_iam_user_login_profile" "login_profile" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

output "user_credentials" {
  sensitive = true
  value     = nonsensitive({ for user, login_profile in aws_iam_user_login_profile.login_profile : user => login_profile.password })
}

# output "users_map" {
#   value = local.flatten_users_map
# }
