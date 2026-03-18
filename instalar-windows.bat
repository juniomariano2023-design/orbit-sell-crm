@echo off
chcp 65001 >nul
cls

echo.
echo  ============================================================
echo   ⊙  ORBIT SELL CRM  -  Instalador Windows
echo  ============================================================
echo.
echo  Este instalador irá:
echo    [1] Verificar o Node.js instalado
echo    [2] Instalar dependências do projeto (npm install)
echo    [3] Compilar o projeto (npm run build)
echo    [4] Criar atalho na área de trabalho
echo    [5] Iniciar o servidor automaticamente
echo.
echo  ------------------------------------------------------------
pause

:: ── Verificar Node.js ──────────────────────────────────────────
echo.
echo  [1/5] Verificando Node.js...
node --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo  [ERRO] Node.js NAO encontrado!
    echo.
    echo  Por favor, instale o Node.js antes de continuar:
    echo  https://nodejs.org  (versao LTS recomendada)
    echo.
    echo  Apos instalar, execute este script novamente.
    echo.
    pause
    exit /b 1
)
FOR /F "tokens=*" %%i IN ('node --version') DO SET NODE_VER=%%i
echo  [OK] Node.js %NODE_VER% encontrado!

:: ── Verificar npm ──────────────────────────────────────────────
npm --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo  [ERRO] npm nao encontrado. Reinstale o Node.js.
    pause
    exit /b 1
)
FOR /F "tokens=*" %%i IN ('npm --version') DO SET NPM_VER=%%i
echo  [OK] npm v%NPM_VER% encontrado!

:: ── Entrar na pasta do projeto ─────────────────────────────────
echo.
echo  [2/5] Instalando dependencias...
cd /d "%~dp0"
echo  Pasta: %CD%
echo.

call npm install
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo  [ERRO] Falha ao instalar dependencias!
    echo  Verifique sua conexao com a internet e tente novamente.
    pause
    exit /b 1
)
echo  [OK] Dependencias instaladas!

:: ── Build ──────────────────────────────────────────────────────
echo.
echo  [3/5] Compilando o projeto...
call npm run build
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo  [ERRO] Falha na compilacao!
    pause
    exit /b 1
)
echo  [OK] Projeto compilado com sucesso!

:: ── Criar script de inicialização ─────────────────────────────
echo.
echo  [4/5] Criando atalhos...

:: Criar iniciar.bat na pasta do projeto
(
echo @echo off
echo chcp 65001 ^>nul
echo cls
echo.
echo  ============================================================
echo   ⊙  ORBIT SELL CRM  -  Iniciando servidor...
echo  ============================================================
echo.
echo  Acesse no navegador: http://localhost:3000
echo  Login: admin@orbitsell.com / admin123
echo.
echo  Pressione CTRL+C para parar o servidor.
echo  ============================================================
echo.
cd /d "%%~dp0"
npx wrangler pages dev dist --ip 0.0.0.0 --port 3000
pause
) > "%~dp0iniciar.bat"

:: Criar atalho na área de trabalho (VBScript)
set SCRIPT_PATH=%~dp0iniciar.bat
set SHORTCUT_PATH=%USERPROFILE%\Desktop\Orbit Sell CRM.lnk

powershell -Command ^
  "$ws = New-Object -ComObject WScript.Shell; " ^
  "$s = $ws.CreateShortcut('%SHORTCUT_PATH%'); " ^
  "$s.TargetPath = '%SCRIPT_PATH%'; " ^
  "$s.WorkingDirectory = '%~dp0'; " ^
  "$s.Description = 'Orbit Sell CRM'; " ^
  "$s.Save()" 2>nul

IF EXIST "%SHORTCUT_PATH%" (
    echo  [OK] Atalho criado na area de trabalho!
) ELSE (
    echo  [AVISO] Atalho nao criado - use iniciar.bat diretamente.
)

:: ── Iniciar servidor ───────────────────────────────────────────
echo.
echo  [5/5] Iniciando o servidor...
echo.
echo  ============================================================
echo   INSTALACAO CONCLUIDA COM SUCESSO!
echo  ============================================================
echo.
echo   Acesse:  http://localhost:3000
echo   Login:   admin@orbitsell.com
echo   Senha:   admin123
echo.
echo   Para iniciar futuramente, use:
echo     - Atalho "Orbit Sell CRM" na area de trabalho
echo     - Ou execute "iniciar.bat" nesta pasta
echo.
echo  ============================================================
echo.

:: Abrir navegador automaticamente após 3 segundos
timeout /t 3 /nobreak >nul
start "" "http://localhost:3000"

:: Iniciar servidor
npx wrangler pages dev dist --ip 0.0.0.0 --port 3000
pause
