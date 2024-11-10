locals {
  project_name = var.project_name
  project      = var.project
}


locals {
  ami_ids = {
    ubuntu  = data.aws_ami.ubuntu.id
    bitnami = data.aws_ami.bitnami.id
  }
}
