resource "aws_db_subnet_group" "main" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = var.db_subnet_group_name
    }
  )
}

resource "aws_security_group" "rds" {
  name        = "${var.db_instance_identifier}-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.allowed_security_groups
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.db_instance_identifier}-sg"
    }
  )
}

resource "aws_db_instance" "main" {
  identifier           = var.db_instance_identifier
  engine              = "postgres"
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  storage_encrypted   = true
  kms_key_id         = var.kms_key_id

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = 5432

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  multi_az            = var.multi_az
  skip_final_snapshot = var.skip_final_snapshot

  tags = merge(
    var.tags,
    {
      Name = var.db_instance_identifier
    }
  )
} 