output "vpc_id" {
  value = aws_vpc.this.id
}

output "azs" {
  value = local.subnet_azs
}

locals {
  output_public_subnets = {
    for key in keys(local.public_subnets) : key => {
      subnet_id = aws_subnet.this[key].id
      az        = aws_subnet.this[key].availability_zone
    }
  }

  output_private_subnets = {
    for key in keys(local.private_subnets) : key => {
      subnet_id = aws_subnet.this[key].id
      az        = aws_subnet.this[key].availability_zone
    }
  }
}

output "public_subnets" {
  value = local.output_public_subnets
}

output "private_subnets" {
  value = local.output_private_subnets
}



