data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "custom-vpc"
  }
}


moved {
  from = aws_subnet.allowed
  to   = aws_subnet.private1
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name   = "subnet-custom-vpc1"
    Access = "Private"
  }
}


resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name   = "subnet-custom-vpc3"
    Access = "Private"
  }
}



resource "aws_subnet" "private3" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name   = "subnet-custom-vpc"
    Access = "Private"
  }
}


resource "aws_subnet" "not_allowed" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"

  tags = {
    Name = "subnet-default-vpc"
  }
}


resource "aws_security_group" "source" {
  name   = "source_sg"
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group" "compliant" {
  name   = "compliant_sg"
  vpc_id = aws_vpc.this.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.non_compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_security_group" "non_compliant" {
  name   = "non-comliant-sg"
  vpc_id = aws_vpc.this.id
}
