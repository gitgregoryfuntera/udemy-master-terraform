import {
  to = aws_iam_openid_connect_provider.terraform_cloud
  id = "arn:aws:iam::736537934211:oidc-provider/app.terraform.io"
}

import {
  to = aws_iam_role.terraform_cloud
  id = "terraform-cloud-automation-admin"
}

import {
  to = aws_iam_role_policy_attachment.terraform_cloud
  id = "${aws_iam_role.terraform_cloud.name}/${data.aws_iam_policy.admin_policy.arn}"
}

data "tls_certificate" "terraform_cloud" {
  url = "https://${var.terraform_cloud_hostname}"
}


resource "aws_iam_openid_connect_provider" "terraform_cloud" {
  url             = data.tls_certificate.terraform_cloud.url
  client_id_list  = [var.terraform_cloud_audience]
  thumbprint_list = [data.tls_certificate.terraform_cloud.certificates[0].sha1_fingerprint]
  tags = {
    "Name" = "Terraform Cloud"
  }
}

data "aws_iam_policy_document" "terraform_cloud_admin_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.terraform_cloud.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${var.terraform_cloud_hostname}:aud"
      values   = [var.terraform_cloud_audience]
    }
    condition {
      test     = "StringLike"
      variable = "${var.terraform_cloud_hostname}:sub"
      values = [
        for workspace in var.terraform_cloud_role_workspaces :
        "organization:terraform-greg-udemy:project:${var.terraform_cloud_role_project}:workspace:${workspace}:run_phase:*"
      ]
    }
  }
}

resource "aws_iam_role" "terraform_cloud" {
  name               = "terraform-cloud-automation-admin"
  assume_role_policy = data.aws_iam_policy_document.terraform_cloud_admin_assume_role.json
}

data "aws_iam_policy" "admin_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "terraform_cloud" {
  role       = aws_iam_role.terraform_cloud.name
  policy_arn = data.aws_iam_policy.admin_policy.arn
}

