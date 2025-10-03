variable "db_password" {
    description = "Senha do banco PostgreSQL"
    type        = string
    sensitive   = true
}

variable "vpc_id" {
    description = "ID da VPC onde o RDS será provisionado"
    type        = string
}

variable "subnet_ids" {
    description = "Lista de Subnets onde o RDS será criado"
    type        = list(string)
}
