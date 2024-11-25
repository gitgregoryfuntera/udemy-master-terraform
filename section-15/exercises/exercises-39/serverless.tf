data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.mjs"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "this" {
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_function_name"
  role             = aws_iam_role.this.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs18.x"
  environment {
    variables = {
      foo = "bar"
    }
  }
}
