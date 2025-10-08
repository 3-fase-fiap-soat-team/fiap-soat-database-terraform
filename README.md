
---

## ⚙️ Descrição

Este repositório define a infraestrutura necessária para o banco de dados **PostgreSQL** em um ambiente AWS, incluindo:

- ✅ **RDS PostgreSQL**
- ✅ **Subnet Group** (em subnets privadas)
- ✅ **Security Group** (com regras de acesso controladas)
- ✅ Integração com **GitHub Actions** para CI/CD
- ✅ Import automático de recursos já existentes no ambiente (para uso em Labs)

---

## 🚀 Fluxo de Deploy

O processo de deploy é totalmente automatizado via **GitHub Actions**.

### 🔁 Disparos Automáticos
- **Pull Request → main:** executa `terraform plan` para validação.
- **Push → main:** executa `terraform apply` para aplicar as mudanças na AWS.

---

## 🔐 Secrets Necessários

Antes de executar o pipeline, configure os seguintes **secrets** no repositório:

| Nome | Descrição |
|------|------------|
| `AWS_ACCESS_KEY_ID` | Chave de acesso da AWS |
| `AWS_SECRET_ACCESS_KEY` | Chave secreta da AWS |
| `AWS_SESSION_TOKEN` | Token temporário de sessão (obrigatório para o Lab) |
| `AWS_DEFAULT_REGION` | Região da AWS (ex: `us-east-1`) |
| `DB_PASSWORD` | Senha do banco de dados PostgreSQL |

---

## 🧩 Variáveis Principais

As variáveis estão definidas no arquivo `envs/dev/variables.tf`:

| Variável | Descrição | Exemplo |
|-----------|------------|---------|
| `db_name` | Nome do banco de dados | `fiap_soat_db` |
| `db_username` | Usuário principal do banco | `postgres` |
| `db_password` | Senha do banco (vinda do secret) | `${{ secrets.DB_PASSWORD }}` |
| `vpc_id` | ID da VPC | `vpc-0bc479b582e33b241` |
| `subnet_ids` | Lista de Subnets privadas | `["subnet-xxxx", "subnet-yyyy"]` |

---

## 🧠 Importação de Recursos Existentes

O pipeline realiza automaticamente o `terraform import` dos recursos que já existem no ambiente, evitando erros de duplicação:

```yaml
terraform import module.rds.aws_db_subnet_group.this rds-subnet-group
terraform import module.rds.aws_security_group.this sg-xxxxxxxxxxxxxxxxx
