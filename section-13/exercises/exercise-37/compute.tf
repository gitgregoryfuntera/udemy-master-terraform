locals {
  allowed_instance_types = ["t2.micro", "t3.micro"]
  available_subnet_azs   = ["ap-southeast-1a", "ap-southeast-1b"]
}

data "aws_availability_zones" "available_azs" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = "true"
  owners      = ["099720109477"] # Owner is Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.this[0].id

  lifecycle {
    # precondition {
    #   condition     = contains(local.allowed_instance_types, var.instance_type)
    #   error_message = "only ${join(",", local.allowed_instance_types)} are allowed"
    # }
    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type)
      error_message = "only ${join(",", local.allowed_instance_types)} are allowed"
    }
    create_before_destroy = true
  }

  tags = {
    ManagedBy  = "terraform"
    CostCenter = "audit"
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "this" {
  count      = length(data.aws_availability_zones.available_azs.names)
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.${128 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available_azs.names[
    count.index % length(data.aws_availability_zones.available_azs.names)
  ]

  lifecycle {
    postcondition {
      condition     = contains(data.aws_availability_zones.available_azs.names, self.availability_zone)
      error_message = "only ${join(",", data.aws_availability_zones.available_azs.names)} are allowed"
    }
  }
}


check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter != "")
    error_message = "CostCenter tag does not exists"
  }
}

check "aws_subnet" {
  assert {
    condition     = length(toset([for subnet in aws_subnet.this : subnet.availability_zone])) > 1
    error_message = "Subnet must be distributed across more than 1 AZ"
  }
}
