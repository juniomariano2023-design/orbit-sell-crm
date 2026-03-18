#!/bin/bash
# ============================================================
#  ⊙  ORBIT SELL CRM  -  Instalador Linux / macOS
# ============================================================

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

clear
echo ""
echo -e "${CYAN}${BOLD} ============================================================${NC}"
echo -e "${CYAN}${BOLD}  ⊙  ORBIT SELL CRM  -  Instalador Linux / macOS${NC}"
echo -e "${CYAN}${BOLD} ============================================================${NC}"
echo ""
echo -e "  Este instalador irá:"
echo -e "    ${GREEN}[1]${NC} Verificar o Node.js instalado"
echo -e "    ${GREEN}[2]${NC} Instalar dependências do projeto"
echo -e "    ${GREEN}[3]${NC} Compilar o projeto (build)"
echo -e "    ${GREEN}[4]${NC} Criar script de inicialização"
echo -e "    ${GREEN}[5]${NC} Iniciar o servidor automaticamente"
echo ""
echo -e " ------------------------------------------------------------"
read -p " Pressione ENTER para continuar..."

# ── Diretório do script ────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ── Verificar Node.js ──────────────────────────────────────────
echo ""
echo -e " ${BOLD}[1/5] Verificando Node.js...${NC}"

if ! command -v node &>/dev/null; then
    echo ""
    echo -e " ${RED}[ERRO] Node.js NÃO encontrado!${NC}"
    echo ""
    echo " Por favor, instale o Node.js antes de continuar:"
    echo ""

    # Detectar SO
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  macOS:"
        echo "    brew install node"
        echo "  Ou acesse: https://nodejs.org"
    else
        echo "  Ubuntu/Debian:"
        echo "    sudo apt update && sudo apt install nodejs npm -y"
        echo "  Ou acesse: https://nodejs.org"
    fi
    echo ""
    exit 1
fi

NODE_VER=$(node --version)
NPM_VER=$(npm --version)
echo -e " ${GREEN}[OK]${NC} Node.js $NODE_VER encontrado!"
echo -e " ${GREEN}[OK]${NC} npm v$NPM_VER encontrado!"

# ── Instalar dependências ──────────────────────────────────────
echo ""
echo -e " ${BOLD}[2/5] Instalando dependências...${NC}"
echo " Pasta: $SCRIPT_DIR"
echo ""

npm install
if [ $? -ne 0 ]; then
    echo ""
    echo -e " ${RED}[ERRO] Falha ao instalar dependências!${NC}"
    echo " Verifique sua conexão com a internet e tente novamente."
    exit 1
fi
echo -e " ${GREEN}[OK]${NC} Dependências instaladas!"

# ── Build ──────────────────────────────────────────────────────
echo ""
echo -e " ${BOLD}[3/5] Compilando o projeto...${NC}"

npm run build
if [ $? -ne 0 ]; then
    echo ""
    echo -e " ${RED}[ERRO] Falha na compilação!${NC}"
    exit 1
fi
echo -e " ${GREEN}[OK]${NC} Projeto compilado com sucesso!"

# ── Criar script de inicialização ─────────────────────────────
echo ""
echo -e " ${BOLD}[4/5] Criando script de inicialização...${NC}"

cat > "$SCRIPT_DIR/iniciar.sh" << 'STARTER'
#!/bin/bash
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
clear
echo ""
echo -e "${CYAN}${BOLD} ============================================================${NC}"
echo -e "${CYAN}${BOLD}  ⊙  ORBIT SELL CRM  -  Servidor iniciado!${NC}"
echo -e "${CYAN}${BOLD} ============================================================${NC}"
echo ""
echo -e "  Acesse no navegador: ${BOLD}http://localhost:3000${NC}"
echo -e "  Login:  admin@orbitsell.com"
echo -e "  Senha:  admin123"
echo ""
echo -e "  Pressione ${BOLD}CTRL+C${NC} para parar."
echo -e " ============================================================"
echo ""
# Abrir navegador automaticamente
if [[ "$OSTYPE" == "darwin"* ]]; then
    sleep 2 && open "http://localhost:3000" &
elif command -v xdg-open &>/dev/null; then
    sleep 2 && xdg-open "http://localhost:3000" &
fi
npx wrangler pages dev dist --ip 0.0.0.0 --port 3000
STARTER

chmod +x "$SCRIPT_DIR/iniciar.sh"
echo -e " ${GREEN}[OK]${NC} Script iniciar.sh criado!"

# Criar atalho no desktop (Linux)
if [[ "$OSTYPE" != "darwin"* ]] && [ -d "$HOME/Desktop" ]; then
    cat > "$HOME/Desktop/OrbitSellCRM.desktop" << DESKTOP
[Desktop Entry]
Version=1.0
Type=Application
Name=Orbit Sell CRM
Comment=Gerenciador de Clientes
Exec=bash "$SCRIPT_DIR/iniciar.sh"
Path=$SCRIPT_DIR
Icon=applications-internet
Terminal=true
Categories=Office;
DESKTOP
    chmod +x "$HOME/Desktop/OrbitSellCRM.desktop"
    echo -e " ${GREEN}[OK]${NC} Atalho criado no Desktop!"
fi

# ── Iniciar ────────────────────────────────────────────────────
echo ""
echo -e " ${BOLD}[5/5] Iniciando o servidor...${NC}"
echo ""
echo -e "${GREEN}${BOLD} ============================================================${NC}"
echo -e "${GREEN}${BOLD}  INSTALAÇÃO CONCLUÍDA COM SUCESSO!${NC}"
echo -e "${GREEN}${BOLD} ============================================================${NC}"
echo ""
echo -e "  Acesse:  ${BOLD}http://localhost:3000${NC}"
echo -e "  Login:   admin@orbitsell.com"
echo -e "  Senha:   admin123"
echo ""
echo -e "  Para iniciar futuramente, execute:"
echo -e "    ${CYAN}bash iniciar.sh${NC}"
echo ""
echo -e " ============================================================"
echo ""

# Abrir navegador
if [[ "$OSTYPE" == "darwin"* ]]; then
    sleep 3 && open "http://localhost:3000" &
elif command -v xdg-open &>/dev/null; then
    sleep 3 && xdg-open "http://localhost:3000" &
fi

# Iniciar servidor
npx wrangler pages dev dist --ip 0.0.0.0 --port 3000
