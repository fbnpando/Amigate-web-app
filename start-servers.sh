#!/bin/bash
# Script para iniciar múltiples servidores Laravel en diferentes puertos
# Linux/Mac Bash Script

echo "Iniciando servidores Laravel en múltiples puertos..."
echo ""

# Configurar variables
SERVER_HOST="127.0.0.1"
PORT_8000=8000
PORT_8001=8001
PORT_8002=8002
PORT_8003=8003
PORT_8004=8004

echo "Puerto 8000: Operaciones de escritura y críticas (Auth, Crear Reportes, Crear Respuestas)"
echo "Puerto 8001: Lectura de Reportes (MUY FRECUENTE)"
echo "Puerto 8002: Notificaciones (MUY FRECUENTE - POLLING)"
echo "Puerto 8003: Geolocalización y Grupos (FRECUENTE)"
echo "Puerto 8004: Lectura de Respuestas (FRECUENTE)"
echo ""

# Función para limpiar procesos al salir
cleanup() {
    echo ""
    echo "Deteniendo todos los servidores..."
    kill $PID_8000 $PID_8001 $PID_8002 $PID_8003 $PID_8004 2>/dev/null
    exit
}

trap cleanup SIGINT SIGTERM

# Iniciar servidor 8000
echo "Iniciando servidor en puerto $PORT_8000..."
APP_ROUTES_FILE=api-8000.php php artisan serve --host=$SERVER_HOST --port=$PORT_8000 > /dev/null 2>&1 &
PID_8000=$!

sleep 1

# Iniciar servidor 8001
echo "Iniciando servidor en puerto $PORT_8001..."
APP_ROUTES_FILE=api-8001.php php artisan serve --host=$SERVER_HOST --port=$PORT_8001 > /dev/null 2>&1 &
PID_8001=$!

sleep 1

# Iniciar servidor 8002
echo "Iniciando servidor en puerto $PORT_8002..."
APP_ROUTES_FILE=api-8002.php php artisan serve --host=$SERVER_HOST --port=$PORT_8002 > /dev/null 2>&1 &
PID_8002=$!

sleep 1

# Iniciar servidor 8003
echo "Iniciando servidor en puerto $PORT_8003..."
APP_ROUTES_FILE=api-8003.php php artisan serve --host=$SERVER_HOST --port=$PORT_8003 > /dev/null 2>&1 &
PID_8003=$!

sleep 1

# Iniciar servidor 8004
echo "Iniciando servidor en puerto $PORT_8004..."
APP_ROUTES_FILE=api-8004.php php artisan serve --host=$SERVER_HOST --port=$PORT_8004 > /dev/null 2>&1 &
PID_8004=$!

echo ""
echo "Todos los servidores están corriendo:"
echo "  - Puerto $PORT_8000: PID $PID_8000"
echo "  - Puerto $PORT_8001: PID $PID_8001"
echo "  - Puerto $PORT_8002: PID $PID_8002"
echo "  - Puerto $PORT_8003: PID $PID_8003"
echo "  - Puerto $PORT_8004: PID $PID_8004"
echo ""
echo "Presiona Ctrl+C para detener todos los servidores"
echo ""

# Esperar a que se detengan
wait

