import {
  to = aws_lambda_function.this
  id = "HelloWorld"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.module}/lambda.zip"
}


# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.
# __generated__ by Terraform
resource "aws_lambda_function" "this" {
  description      = "Imported from terraform"
  filename         = "lambda.zip"
  function_name    = "HelloWorld"
  handler          = "index.handler"
  package_type     = "Zip"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "nodejs20.x"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  tags             = {}
  tags_all         = {}
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/HelloWorld"
  }
}

