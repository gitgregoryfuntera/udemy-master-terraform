import {
  to = aws_iam_role.lambda_execution_role
  id = "serverless_lambda"
}

import {
  to = aws_iam_policy.basic_execution_role
  id = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "assume_lambda_execution_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
resource "aws_iam_policy" "basic_execution_role" {
  description = "Provides write permissions to CloudWatch Logs."
  name        = "AWSLambdaBasicExecutionRole"
  path        = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["*"]
    }]
    Version = "2012-10-17"
  })
  tags     = {}
  tags_all = {}
}

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.
# __generated__ by Terraform from "serverless_lambda"
resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_execution_role.json
  name               = "serverless_lambda"
  path               = "/"
  tags               = {}
  tags_all           = {}
}

