# Subnet Group para o RDS
resource "aws_db_subnet_group" "this" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

# Security Group para o RDS
resource "aws_security_group" "this" {
  name        = "rds-sg"
  description = "Allow PostgreSQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Para testes apenas, restrinja em produção
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instância RDS PostgreSQL
resource "aws_db_instance" "this" {
  identifier              = "fiap-soat-db"
  engine                  = "postgres"
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_type            = "gp2"

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = 5432

  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  skip_final_snapshot     = true
  monitoring_interval     = 0 # Desativa Enhanced Monitoring no AWS Academy Lab

  tags = {
    Name = "fiap-soat-db"
  }
}