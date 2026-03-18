# ⊙ Orbit Sell CRM — Guia de Instalação

## 📋 Pré-requisito obrigatório

Antes de instalar, você precisa ter o **Node.js** instalado no seu computador.

### Baixar Node.js:
👉 **https://nodejs.org** — baixe a versão **LTS** (recomendada)

---

## 🪟 Windows

### Passo a passo:
1. Instale o **Node.js** (link acima)
2. Extraia o arquivo `.zip` / `.tar.gz` do projeto
3. **Duplo clique** em `instalar-windows.bat`
4. Aguarde a instalação automática
5. O navegador abrirá em **http://localhost:3000**

> ⚠️ Se o Windows perguntar "Deseja permitir?", clique em **Sim / Executar assim mesmo**

---

## 🍎 macOS

### Passo a passo:
1. Instale o Node.js ou execute: `brew install node`
2. Extraia o arquivo do projeto
3. Abra o Terminal na pasta do projeto
4. Execute:
```bash
bash instalar-linux-mac.sh
```
5. O navegador abrirá em **http://localhost:3000**

---

## 🐧 Linux (Ubuntu / Debian)

### Passo a passo:
```bash
# 1. Instalar Node.js (se não tiver)
sudo apt update && sudo apt install nodejs npm -y

# 2. Entrar na pasta do projeto
cd orbit-sell-crm

# 3. Executar o instalador
bash instalar-linux-mac.sh
```

---

## 🔑 Login padrão

| Campo | Valor |
|-------|-------|
| **E-mail** | admin@orbitsell.com |
| **Senha** | admin123 |

> Você pode criar novos usuários clicando em **"Criar Conta"** na tela de login.

---

## 🚀 Iniciar após instalação

Após a primeira instalação, para iniciar o CRM futuramente:

**Windows:** Duplo clique em `iniciar.bat`  
**macOS/Linux:** Execute `bash iniciar.sh` no terminal

---

## 🌐 Acessar o sistema

Abra o navegador e acesse: **http://localhost:3000**

---

## ❓ Problemas comuns

| Problema | Solução |
|----------|---------|
| "node não reconhecido" | Instale o Node.js em nodejs.org |
| Porta 3000 em uso | Feche outros programas ou reinicie o PC |
| Tela em branco | Pressione F5 para recarregar |
| Erro de permissão (Linux) | Execute `chmod +x instalar-linux-mac.sh` |

---

*Orbit Sell CRM © 2026 — Todos os direitos reservados*
