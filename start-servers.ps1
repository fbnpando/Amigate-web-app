# Script PowerShell para iniciar múltiples servidores Laravel
# Mejor alternativa para PowerShell

Write-Host "Iniciando servidores Laravel en múltiples puertos..." -ForegroundColor Cyan
Write-Host ""

$SERVER_HOST = "127.0.0.1"
$ports = @(
    @{Port=8000; RoutesFile="api-8000.php"; Name="Operaciones de escritura y críticas"},
    @{Port=8001; RoutesFile="api-8001.php"; Name="Lectura de Reportes (MUY FRECUENTE)"},
    @{Port=8002; RoutesFile="api-8002.php"; Name="Notificaciones (MUY FRECUENTE - POLLING)"},
    @{Port=8003; RoutesFile="api-8003.php"; Name="Geolocalización y Grupos (FRECUENTE)"},
    @{Port=8004; RoutesFile="api-8004.php"; Name="Lectura de Respuestas (FRECUENTE)"}
)

foreach ($portConfig in $ports) {
    Write-Host "Iniciando Puerto $($portConfig.Port): $($portConfig.Name)" -ForegroundColor Yellow
    
    $scriptBlock = {
        param($host, $port, $routesFile)
        
        if ($routesFile) {
            $env:APP_ROUTES_FILE = $routesFile
        }
        
        php artisan serve --host=$host --port=$port
    }
    
    if ($portConfig.RoutesFile) {
        Start-Process powershell -ArgumentList "-NoExit", "-Command", "`$env:APP_ROUTES_FILE='$($portConfig.RoutesFile)'; Write-Host 'Servidor Puerto $($portConfig.Port) iniciado' -ForegroundColor Green; php artisan serve --host=$SERVER_HOST --port=$($portConfig.Port)"
    } else {
        Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'Servidor Puerto $($portConfig.Port) iniciado' -ForegroundColor Green; php artisan serve --host=$SERVER_HOST --port=$($portConfig.Port)"
    }
    
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "✓ Todos los servidores han sido iniciados en ventanas separadas." -ForegroundColor Green
Write-Host "Para detener todos los servidores, cierra cada ventana." -ForegroundColor Yellow
Write-Host ""
Write-Host "Puertos activos:" -ForegroundColor Cyan
foreach ($portConfig in $ports) {
    Write-Host "  - Puerto $($portConfig.Port): http://${SERVER_HOST}:$($portConfig.Port)" -ForegroundColor White
}

