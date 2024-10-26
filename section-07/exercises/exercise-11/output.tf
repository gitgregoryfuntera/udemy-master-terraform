data "aws_vpc" "existing_vpc" {
  tags = {
    Env = "Prod"
  }
}


output "vpc_tags" {
    value = data.aws_vpc.existing_vpc.tags
}

output "vpc_id" {
    value = data.aws_vpc.existing_vpc.id
}