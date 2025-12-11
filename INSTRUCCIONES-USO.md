# 📋 Instrucciones de Uso - Arquitectura Multi-Puerto

## ⚠️ Nota Importante para PowerShell

En **PowerShell**, siempre debes usar `.\` antes del nombre del script para ejecutarlo desde la ubicación actual:

```powershell
# ✅ Correcto
.\start-servers.bat
.\test-ports.bat

# ❌ Incorrecto (genera error)
start-servers.bat
test-ports.bat
```

## 🚀 Iniciar los Servidores

### Opción 1: Usar el script batch (Recomendado)
```powershell
.\start-servers.bat
```

Esto abrirá **5 ventanas separadas**, una para cada puerto. Podrás ver los logs de cada servidor individualmente.

### Opción 2: Usar PowerShell directamente
```powershell
.\test-ports.ps1
```

### Opción 3: Iniciar manualmente cada puerto

Abre **5 terminales separadas** y ejecuta en cada una:

**Terminal 1 - Puerto 8000:**
```powershell
php artisan serve --host=192.168.100.58 --port=8000
```

**Terminal 2 - Puerto 8001:**
```powershell
$env:APP_ROUTES_FILE="api-8001.php"
php artisan serve --host=192.168.100.58 --port=8001
```

**Terminal 3 - Puerto 8002:**
```powershell
$env:APP_ROUTES_FILE="api-8002.php"
php artisan serve --host=192.168.100.58 --port=8002
```

**Terminal 4 - Puerto 8003:**
```powershell
$env:APP_ROUTES_FILE="api-8003.php"
php artisan serve --host=192.168.100.58 --port=8003
```

**Terminal 5 - Puerto 8004:**
```powershell
$env:APP_ROUTES_FILE="api-8004.php"
php artisan serve --host=192.168.100.58 --port=8004
```

## 🧪 Probar los Puertos

### Opción 1: Script Batch
```powershell
.\test-ports.bat
```

### Opción 2: Script PowerShell (Más detallado)
```powershell
.\test-ports.ps1
```

### Opción 3: Probar manualmente en el navegador

Abre tu navegador y visita:
- http://192.168.100.58:8000/api/ping
- http://192.168.100.58:8001/api/ping
- http://192.168.100.58:8002/api/ping
- http://192.168.100.58:8003/api/ping
- http://192.168.100.58:8004/api/ping

Deberías ver respuestas JSON con el mensaje de cada puerto.

## 🛑 Detener los Servidores

Si usaste `start-servers.bat`, simplemente cierra cada ventana del servidor.

Si iniciaste manualmente, presiona `Ctrl+C` en cada terminal.

## 🔍 Verificar que los Servidores Están Corriendo

### En PowerShell:
```powershell
netstat -ano | findstr :8000
netstat -ano | findstr :8001
netstat -ano | findstr :8002
netstat -ano | findstr :8003
netstat -ano | findstr :8004
```

Deberías ver cada puerto listando con estado `LISTENING`.

## 📱 Actualizar tu Cliente/Frontend

En tu aplicación frontend, actualiza las URLs base:

```javascript
const API_ENDPOINTS = {
  CRITICAL: 'http://192.168.100.58:8000/api',
  REPORTS: 'http://192.168.100.58:8001/api',
  NOTIFICATIONS: 'http://192.168.100.58:8002/api',
  LOCATION: 'http://192.168.100.58:8003/api',
  ANSWERS: 'http://192.168.100.58:8004/api',
};

// Ejemplos de uso:
// Login
fetch(`${API_ENDPOINTS.CRITICAL}/auth/login`, {...});

// Obtener reportes
fetch(`${API_ENDPOINTS.REPORTS}/reportes/grupo/${grupoId}`);

// Notificaciones
fetch(`${API_ENDPOINTS.NOTIFICATIONS}/notificaciones/usuario/${userId}/no-leidas`);
```

## ⚠️ Solución de Problemas

### Error: "Puerto ya en uso"
```powershell
# Encontrar proceso usando el puerto
netstat -ano | findstr :8001

# Matar el proceso (reemplaza PID con el número que encuentres)
taskkill /PID <PID> /F
```

### Error: "Route not found"
- Verifica que el archivo de rutas correspondiente existe en `routes/`
- Verifica que la variable `APP_ROUTES_FILE` está configurada correctamente
- Reinicia el servidor después de cambios

### Los servidores no inician
1. Verifica que PHP está instalado: `php -v`
2. Verifica que estás en el directorio correcto del proyecto
3. Verifica permisos de archivos

## 📊 Monitoreo

Cada servidor muestra logs en su ventana correspondiente. Monitorea:
- Tiempos de respuesta
- Errores 404 o 500
- Frecuencia de peticiones

