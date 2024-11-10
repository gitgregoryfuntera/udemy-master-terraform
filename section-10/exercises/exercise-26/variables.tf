variable "project" {
  type    = string
  default = "Project"
}

variable "project_name" {
  type    = string
  default = "ProjectName"
}

variable "subnet_count" {
  type = number
}


locals {
  project_name = var.project_name
  project      = var.project
}
