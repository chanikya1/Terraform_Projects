resource "aws_db_subnet_group" "this" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "this" {
  identifier                 = var.db_identifier
  allocated_storage          = 20
  engine                     = var.engine
  instance_class             = var.instance_class
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = var.db_password
  skip_final_snapshot        = true
  publicly_accessible        = false
  vpc_security_group_ids     = [var.security_group_id]
  db_subnet_group_name       = aws_db_subnet_group.this.name
  multi_az                   = false
  auto_minor_version_upgrade = true

  tags = var.tags
}

