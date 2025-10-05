terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}

# Data source para descobrir a VPC padrão automaticamente
data "aws_vpc" "default" {
  default = true
}

# Data source para descobrir todas as subnets da VPC padrão
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "rds" {
  source = "../../modules/rds"

  db_name              = "fiapdb_dev"
  db_username          = "postgresadmin"
  db_password          = var.db_password
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  db_engine_version    = "17.4"

  # Usa automaticamente a VPC padrão e suas subnets
  subnet_ids = data.aws_subnets.default.ids
  vpc_id     = data.aws_vpc.default.id
}

# Outputs do módulo RDS
output "rds_endpoint" {
  description = "Endpoint do banco de dados RDS"
  value       = module.rds.rds_endpoint
}

output "rds_db_name" {
  description = "Nome do banco de dados criado"
  value       = module.rds.rds_db_name
}

output "rds_username" {
  description = "Usuário administrador do banco de dados"
  value       = module.rds.rds_username
  sensitive   = true
}

# Outputs adicionais para debug
output "vpc_id" {
  description = "ID da VPC padrão descoberta"
  value       = data.aws_vpc.default.id
}

output "subnet_ids" {
  description = "IDs das subnets descobertas"
  value       = data.aws_subnets.default.ids
}
