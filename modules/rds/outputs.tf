output "rds_endpoint" {
  description = "Endpoint do banco de dados RDS"
  value       = aws_db_instance.this.endpoint
}

output "rds_db_name" {
  description = "Nome do banco de dados criado"
  value       = aws_db_instance.this.db_name
}

output "rds_username" {
  description = "Usuário administrador do banco de dados"
  value       = aws_db_instance.this.username
  sensitive   = true
}

