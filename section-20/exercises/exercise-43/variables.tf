variable "terraform_cloud_hostname" {
  type    = string
  default = "app.terraform.io"
}


variable "terraform_cloud_audience" {
  type    = string
  default = "aws.workload.identity"
}


variable "terraform_cloud_role_workspaces" {
  type = list(string)
}

variable "terraform_cloud_role_project" {
  type = string
}

