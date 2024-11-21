locals {
  public_subnets = {
    for key, config in var.subnet_config : key => config if config.public
  }
  private_subnets = {
    for key, config in var.subnet_config : key => config if !config.public
  }

  subnet_azs = {
    for key, config in var.subnet_config : key => config.az
  }
}

data "aws_availability_zones" "available_az" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "this" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr_block

  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.available_az.names, each.value.az)
      error_message = <<-EOT
      The AZ ${each.value.az} is invalid.

      Subnet key: ${each.key}
      AWS Region: ${data.aws_availability_zones.available_az.id}
      Invalid AZ: ${each.value.az}
      List of supported AZs: [${join(", ", data.aws_availability_zones.available_az.names)}]
      EOT
    }
  }

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "this" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }
}

resource "aws_route_table_association" "this" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.this[0].id
}


