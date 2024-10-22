locals {
  common_tags = {
    ManagedBy = "Terraform"
    Name      = "NGINX VPC"
  }
}

resource "aws_vpc" "nginx_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = local.common_tags
}

resource "aws_subnet" "nginx_public_subnet" {
  vpc_id     = aws_vpc.nginx_vpc.id
  cidr_block = "10.0.0.0/24"
  tags       = local.common_tags
}


resource "aws_internet_gateway" "nginx_igw" {
  vpc_id = aws_vpc.nginx_vpc.id
  tags   = local.common_tags
}

resource "aws_route_table" "nginx_public_route_table" {
  vpc_id = aws_vpc.nginx_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx_igw.id
  }
  tags = merge(local.common_tags, {
    Name = "NGINX PUBLIC"
  })
}

resource "aws_route_table_association" "nginx_public_route_table_association" {
  subnet_id      = aws_subnet.nginx_public_subnet.id
  route_table_id = aws_route_table.nginx_public_route_table.id
}


# resource "aws_security_group" "nginx_server" {
#   name   = "nginx server security groups"
#   vpc_id = aws_vpc.nginx_vpc.id
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_to_port_443" {
#   security_group_id = aws_security_group.nginx_server.id
#   cidr_ipv4         = aws_vpc.nginx_vpc.cidr_block
#   ip_protocol       = "tcp"
#   from_port         = "443"
#   to_port           = "443"
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_to_port_80" {
#   security_group_id = aws_security_group.nginx_server.id
#   cidr_ipv4         = aws_vpc.nginx_vpc.cidr_block
#   ip_protocol       = "tcp"
#   from_port         = "80"
#   to_port           = "80"
# }

# resource "aws_instance" "nginx_server_instance" {
#   ami                    = "ami-04b6019d38ea93034"
#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [aws_security_group.nginx_server.id]
# }

