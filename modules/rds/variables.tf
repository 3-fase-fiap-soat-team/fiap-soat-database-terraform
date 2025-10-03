variable "db_name" {
    description = "Nome do banco de dados"
    type        = string
}

variable "db_username" {
    description = "Usuário administrador do banco"
    type        = string
}

variable "db_password" {
    description = "Senha do banco de dados"
    type        = string
    sensitive   = true
}

variable "db_instance_class" {
    description = "Classe da instância RDS"
    type        = string
    default     = "db.t3.micro"
}

variable "db_allocated_storage" {
    description = "Armazenamento em GB"
    type        = number
    default     = 20
}

variable "db_engine_version" {
    description = "Versão do PostgreSQL"
    type        = string
    default     = "15.4"
}

variable "subnet_ids" {
    description = "Lista de Subnets onde o RDS será criado"
    type        = list(string)
}

variable "vpc_id" {
    description = "ID da VPC onde o RDS será provisionado"
    type        = string
}
