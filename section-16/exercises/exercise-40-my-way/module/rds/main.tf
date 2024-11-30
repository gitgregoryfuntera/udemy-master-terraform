resource "aws_db_instance" "this" {
  identifier             = var.project_name
  db_name                = var.rds_name
  allocated_storage      = var.rds_allocated_storage
  engine                 = var.rds_engine
  instance_class         = var.rds_instance_class
  username               = var.rds_credential.username
  password               = var.rds_credential.password
  skip_final_snapshot    = true
  vpc_security_group_ids = var.rds_sg_ids
  db_subnet_group_name   = aws_db_subnet_group.this.name
}

resource "aws_db_subnet_group" "this" {
  name       = "rds_subnet"
  subnet_ids = var.rds_subnet_ids
}



