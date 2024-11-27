# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
resource "aws_iam_policy" "execution_role" {
  description = "Provides write permissions to CloudWatch Logs."
  name        = "AWSLambdaBasicExecutionRole"
  name_prefix = null
  path        = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
  tags     = {}
  tags_all = {}
}
