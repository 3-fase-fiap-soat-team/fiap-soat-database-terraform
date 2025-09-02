# FIAP SOAT - Database Infrastructure

Terraform para RDS PostgreSQL - Fase 3

## Estrutura
- `environments/` - Configurações por ambiente
- `modules/` - Módulos Terraform reutilizáveis
- `scripts/` - Scripts de migração

## Responsável
- **Dev 1 (MathLuchiari)** - Database + Lambda

## Uso
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```
