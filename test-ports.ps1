# Script PowerShell para probar que todos los puertos están funcionando

Write-Host "Probando conectividad de todos los puertos..." -ForegroundColor Cyan
Write-Host ""

$SERVER_HOST = "192.168.100.58"
$ports = @(
    @{Port=8000; Name="Operaciones críticas"},
    @{Port=8001; Name="Lectura de reportes"},
    @{Port=8002; Name="Notificaciones"},
    @{Port=8003; Name="Geolocalización"},
    @{Port=8004; Name="Respuestas"}
)

foreach ($portConfig in $ports) {
    $url = "http://${SERVER_HOST}:$($portConfig.Port)/api/ping"
    Write-Host "Puerto $($portConfig.Port): $($portConfig.Name)" -ForegroundColor Yellow
    
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 2
        $json = $response.Content | ConvertFrom-Json
        Write-Host "✓ OK - $($json.message)" -ForegroundColor Green
        Write-Host "  Timestamp: $($json.timestamp)" -ForegroundColor Gray
    } catch {
        Write-Host "✗ ERROR: Servidor no responde o no está corriendo" -ForegroundColor Red
        Write-Host "  Detalle: $($_.Exception.Message)" -ForegroundColor Gray
    }
    Write-Host ""
}

Write-Host "Pruebas completadas." -ForegroundColor Cyan
Read-Host "Presiona Enter para continuar"

