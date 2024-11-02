locals {
  project       = "terraform_udemy"
  project_owner = "terraform"
  cost_center   = "personal"
  managed_by    = "terraform_team"
}

locals {
  custom_tags = {
    project       = local.project
    project_owner = local.project_owner
    cost_center   = local.cost_center
    managed_by    = local.managed_by
  }
}


