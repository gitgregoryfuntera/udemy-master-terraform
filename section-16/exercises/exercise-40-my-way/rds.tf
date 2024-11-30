data "aws_rds_engine_version" "this" {
  latest = true
  engine = "postgres"
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private_subnet_main" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "private_subnet_secondary" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1b"
}

resource "aws_security_group" "this" {
  name        = "rds_sg"
  description = "RDS security group"
  vpc_id      = aws_vpc.this.id
  tags = {
    Name = "allow_port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres_port_5432" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_postgres_all_traffic" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

module "rds_module" {
  source                = "./module/rds"
  project_name          = "terraform-udemy-rds"
  rds_name              = "udemy_rds"
  rds_allocated_storage = 10
  rds_engine            = data.aws_rds_engine_version.this.engine
  rds_instance_class    = "db.t3.micro"
  rds_subnet_ids        = [aws_subnet.private_subnet_main.id, aws_subnet.private_subnet_secondary.id]
  rds_credential = {
    username = "postgres"
    password = "postgres"
  }
  rds_sg_ids = [aws_security_group.this.id]
}
