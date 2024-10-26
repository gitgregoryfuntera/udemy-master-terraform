data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "S3ReadAccess"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

output "policy" {
  value = data.aws_iam_policy_document.policy.json
}