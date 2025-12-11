@echo off
REM Script para probar que todos los puertos están funcionando

echo Probando conectividad de todos los puertos...
echo.

set SERVER_HOST=192.168.100.58

echo Puerto 8000: Operaciones críticas
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://%SERVER_HOST%:8000/api/ping' -UseBasicParsing -TimeoutSec 2; Write-Host $response.Content } catch { Write-Host 'ERROR: Servidor no responde' -ForegroundColor Red }"
echo.
echo.

echo Puerto 8001: Lectura de reportes
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://%SERVER_HOST%:8001/api/ping' -UseBasicParsing -TimeoutSec 2; Write-Host $response.Content } catch { Write-Host 'ERROR: Servidor no responde' -ForegroundColor Red }"
echo.
echo.

echo Puerto 8002: Notificaciones
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://%SERVER_HOST%:8002/api/ping' -UseBasicParsing -TimeoutSec 2; Write-Host $response.Content } catch { Write-Host 'ERROR: Servidor no responde' -ForegroundColor Red }"
echo.
echo.

echo Puerto 8003: Geolocalización
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://%SERVER_HOST%:8003/api/ping' -UseBasicParsing -TimeoutSec 2; Write-Host $response.Content } catch { Write-Host 'ERROR: Servidor no responde' -ForegroundColor Red }"
echo.
echo.

echo Puerto 8004: Respuestas
powershell -Command "try { $response = Invoke-WebRequest -Uri 'http://%SERVER_HOST%:8004/api/ping' -UseBasicParsing -TimeoutSec 2; Write-Host $response.Content } catch { Write-Host 'ERROR: Servidor no responde' -ForegroundColor Red }"
echo.
echo.

echo Pruebas completadas.
pause

