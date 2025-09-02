# FIAP SOAT - Database Infrastructure

Terraform para RDS PostgreSQL - Fase 3

## 🎯 **Objetivo**
Provisionar e gerenciar infraestrutura de banco de dados PostgreSQL na AWS usando Terraform, otimizado para AWS Academy.

## 👨‍💻 **Responsável**
- **Dev 1 (MathLuchiari)** - Database + Lambda
- **Repositórios:** `fiap-soat-database-terraform` + `fiap-soat-lambda`
- **Foco:** RDS PostgreSQL + Autenticação via CPF
- **Tecnologias:** Terraform, AWS RDS, PostgreSQL, VPC, Security Groups

## 📁 **Estrutura do Projeto**
```
environments/
├── dev/               # Ambiente desenvolvimento
│   ├── main.tf        # Configuração principal
│   ├── variables.tf   # Variáveis do ambiente
│   ├── outputs.tf     # Outputs do Terraform
│   └── backend.tf     # Configuração do backend S3
├── prod/              # Ambiente produção (futuro)
modules/
├── rds/               # Módulo RDS PostgreSQL
│   ├── main.tf        # Recurso RDS
│   ├── variables.tf   # Variáveis do módulo
│   └── outputs.tf     # Outputs do módulo
├── vpc/               # Módulo VPC e networking
└── security/          # Security Groups e IAM
scripts/
├── migrations/        # Scripts de migração
└── backups/           # Scripts de backup
```

## ⚙️ **Configuração AWS Academy**
- **Região:** us-east-1
- **Budget:** $50 USD (AWS Academy)
- **RDS:** PostgreSQL t3.micro (Free Tier elegível)
- **Storage:** 20GB GP2 (mínimo)
- **Multi-AZ:** Desabilitado (economia)
- **Backups:** 7 dias retention

## 🚀 **Setup Local**
```bash
# Clonar repositório
git clone https://github.com/3-fase-fiap-soat-team/fiap-soat-database-terraform.git
cd fiap-soat-database-terraform

# Configurar Git
git config user.name "MathLuchiari"
git config user.email "seu-email@gmail.com"

# Instalar Terraform
# Ubuntu/Debian:
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Verificar instalação
terraform version
```

## 🏗️ **Desenvolvimento**
```bash
# Inicializar Terraform
cd environments/dev
terraform init

# Planejar mudanças
terraform plan

# Aplicar mudanças (cuidado com custos!)
terraform apply

# Verificar estado
terraform show

# Destruir recursos (quando necessário)
terraform destroy
```

## 🔐 **Backend Terraform (Auto-configurado)**
```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = "fiap-soat-terraform-state-1756788008"
    key            = "database/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "fiap-soat-terraform-locks"
    encrypt        = true
  }
}
```

## 📋 **Recursos AWS Gerenciados**
- **RDS PostgreSQL:** Instância t3.micro
- **VPC:** Rede isolada para o projeto
- **Subnets:** Privadas para RDS
- **Security Groups:** Acesso restrito
- **Parameter Groups:** Otimizados para PostgreSQL
- **Secrets Manager:** Credenciais do banco (opcional)

## 🔄 **Workflow de Desenvolvimento**
1. **Branch:** `feature/[nome-da-feature]`
2. **Desenvolvimento:** Modificar Terraform
3. **Teste:** `terraform plan` antes do commit
4. **PR:** Solicitar review do team
5. **CI/CD:** GitHub Actions valida Terraform
6. **Deploy:** Manual após aprovação (cuidado com custos)

## 🧪 **CI/CD Pipeline**
- **Trigger:** Push na `main` ou PR
- **Validação:** `terraform validate`
- **Linting:** `tflint` + `terraform fmt`
- **Plan:** `terraform plan` (comentário no PR)
- **Apply:** Manual para produção

## 💰 **Otimizações de Custo AWS Academy**
```hcl
# Configurações econômicas
instance_class          = "db.t3.micro"  # Free Tier
allocated_storage       = 20             # Mínimo
storage_type           = "gp2"           # Mais barato
multi_az              = false            # Economia
backup_retention_period = 1             # Mínimo
deletion_protection    = false          # Facilita testes
```

## 📚 **Variáveis Importantes**
```hcl
# variables.tf
variable "db_instance_class" {
  default = "db.t3.micro"  # AWS Academy friendly
}

variable "allocated_storage" {
  default = 20  # Mínimo para PostgreSQL
}

variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "fiap-soat"
}
```

## 🔐 **Secrets GitHub (Auto-configurados)**
- `AWS_ACCESS_KEY_ID` - Chave de acesso AWS Academy
- `AWS_SECRET_ACCESS_KEY` - Secret de acesso AWS Academy
- `AWS_SESSION_TOKEN` - Token de sessão AWS Academy
- `TF_STATE_BUCKET` - Bucket S3 para state
- `TF_STATE_LOCK_TABLE` - DynamoDB para locks

## 📚 **Links Importantes**
- **Organização:** https://github.com/3-fase-fiap-soat-team
- **Lambda Repo:** https://github.com/3-fase-fiap-soat-team/fiap-soat-lambda
- **Terraform Docs:** https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- **RDS Docs:** https://docs.aws.amazon.com/rds/

## ⚠️ **Importante - AWS Academy**
- **Budget limitado:** $50 USD total
- **RDS custa ~$15/mês:** Destruir quando não usar
- **Credenciais temporárias:** Renovar quando expirar
- **Monitorar custos:** AWS Cost Explorer
- **Multi-AZ desabilitado:** Para economia de custos

## 🛡️ **Segurança**
- VPC isolada com subnets privadas
- Security Groups restritivos
- Encryption at rest habilitado
- SSL/TLS obrigatório para conexões
- Credenciais via Secrets Manager
