resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Project = local.project
    Name    = local.project_name
  }
}

resource "aws_subnet" "subnet" {
  for_each   = var.subnet_config_map
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value.cidr_block
  tags = {
    Project = local.project
    Name    = "${local.project_name}-${each.key}"
  }
}

