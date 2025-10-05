#!/bin/bash

echo "=== Configuração de Credenciais LabRole AWS Academy ==="
echo ""
echo "Para usar a LabRole, você precisa:"
echo "1. Ir no Console AWS Academy"
echo "2. Clicar em 'AWS Details' no seu lab"
echo "3. Procurar por 'AWS CLI' ou 'LabRole Credentials'"
echo "4. Copiar as credenciais que incluem a LabRole"
echo ""
echo "As credenciais devem ter este formato:"
echo "aws_access_key_id=ASIA..."
echo "aws_secret_access_key=..."
echo "aws_session_token=..."
echo ""
echo "Cole as credenciais da LabRole aqui (Ctrl+D para terminar):"

# Lê as credenciais
CREDENTIALS=$(cat)

# Extrai as informações
ACCESS_KEY=$(echo "$CREDENTIALS" | grep -o 'aws_access_key_id=.*' | cut -d'=' -f2)
SECRET_KEY=$(echo "$CREDENTIALS" | grep -o 'aws_secret_access_key=.*' | cut -d'=' -f2)
SESSION_TOKEN=$(echo "$CREDENTIALS" | grep -o 'aws_session_token=.*' | cut -d'=' -f2)

if [[ -n "$ACCESS_KEY" && -n "$SECRET_KEY" && -n "$SESSION_TOKEN" ]]; then
    echo "✅ Credenciais extraídas com sucesso!"
    
    # Configura as credenciais
    aws configure set aws_access_key_id "$ACCESS_KEY" --profile labrole
    aws configure set aws_secret_access_key "$SECRET_KEY" --profile labrole
    aws configure set aws_session_token "$SESSION_TOKEN" --profile labrole
    aws configure set region us-east-1 --profile labrole
    
    echo "✅ Credenciais LabRole configuradas!"
    
    # Testa a conexão
    echo ""
    echo "🧪 Testando conexão com LabRole..."
    if aws sts get-caller-identity --profile labrole; then
        echo "✅ Conexão com LabRole estabelecida com sucesso!"
    else
        echo "❌ Erro ao conectar com LabRole"
        exit 1
    fi
else
    echo "❌ Erro ao extrair credenciais. Verifique o formato."
    exit 1
fi
