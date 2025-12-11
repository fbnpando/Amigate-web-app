@echo off
REM Script para iniciar múltiples servidores Laravel en diferentes puertos
REM Windows Batch Script

echo Iniciando servidores Laravel en múltiples puertos...
echo.

REM Configurar variables de entorno para cada puerto
set SERVER_8000_PORT=8000
set SERVER_8001_PORT=8001
set SERVER_8002_PORT=8002
set SERVER_8003_PORT=8003
set SERVER_8004_PORT=8004
set SERVER_HOST=10.26.3.219

echo Puerto 8000: Operaciones de escritura y críticas (Auth, Crear Reportes, Crear Respuestas)
echo Puerto 8001: Lectura de Reportes (MUY FRECUENTE)
echo Puerto 8002: Notificaciones (MUY FRECUENTE - POLLING)
echo Puerto 8003: Geolocalizacion y Grupos (FRECUENTE)
echo Puerto 8004: Lectura de Respuestas (FRECUENTE)
echo.

REM Iniciar cada servidor en una nueva ventana usando cmd.exe directamente
start cmd /k "cd /d %~dp0 && title Laravel Server - Puerto 8000 && php artisan serve --host=%SERVER_HOST% --port=%SERVER_8000_PORT%"
timeout /t 2 /nobreak >nul

start cmd /k "cd /d %~dp0 && title Laravel Server - Puerto 8001 && set APP_ROUTES_FILE=api-8001.php && php artisan serve --host=%SERVER_HOST% --port=%SERVER_8001_PORT%"
timeout /t 2 /nobreak >nul

start cmd /k "cd /d %~dp0 && title Laravel Server - Puerto 8002 && set APP_ROUTES_FILE=api-8002.php && php artisan serve --host=%SERVER_HOST% --port=%SERVER_8002_PORT%"
timeout /t 2 /nobreak >nul

start cmd /k "cd /d %~dp0 && title Laravel Server - Puerto 8003 && set APP_ROUTES_FILE=api-8003.php && php artisan serve --host=%SERVER_HOST% --port=%SERVER_8003_PORT%"
timeout /t 2 /nobreak >nul

start cmd /k "cd /d %~dp0 && title Laravel Server - Puerto 8004 && set APP_ROUTES_FILE=api-8004.php && php artisan serve --host=%SERVER_HOST% --port=%SERVER_8004_PORT%"

echo.
echo Todos los servidores han sido iniciados en ventanas separadas.
echo Para detener todos los servidores, cierra cada ventana.
pause

