variable "db_password" {
  description = "Senha do banco PostgreSQL"
  type        = string
  sensitive   = true
}

# Variáveis vpc_id e subnet_ids removidas - são descobertas automaticamente
