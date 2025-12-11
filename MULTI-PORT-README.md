# 🚀 Arquitectura Multi-Puerto - Sistema de Reportes

## 📊 Análisis de Carga

Basado en el análisis de logs, se ha dividido la API en **5 puertos especializados** para optimizar el rendimiento:

### 📈 Distribución por Frecuencia y Tipo

| Puerto | Tipo de Peticiones | Frecuencia | Tiempo Promedio |
|--------|-------------------|------------|-----------------|
| **8000** | Escritura y críticas | Baja | Variable (algunos lentos ~17s) |
| **8001** | Lectura de reportes | **MUY ALTA** | 0.2ms - 515ms (algunos ~4s) |
| **8002** | Notificaciones | **MUY ALTA** | 0.15ms - 7s (polling constante) |
| **8003** | Geolocalización | Alta | 0.5ms - 17s (algunos lentos) |
| **8004** | Lectura de respuestas | Alta | 0.3ms - 8s (algunos lentos) |

---

## 🎯 Puertos y Endpoints

### **Puerto 8000** - Operaciones de Escritura y Críticas
**Propósito**: Auth, creación de reportes/respuestas, operaciones administrativas

**Endpoints**:
- `POST /api/auth/login` - Login de usuarios
- `POST /api/auth/register` - Registro de usuarios
- `GET /api/auth/perfil/{usuarioId}` - Ver perfil
- `PUT /api/auth/perfil/{usuarioId}` - Actualizar perfil
- `PUT /api/auth/ubicacion/{usuarioId}` - Actualizar ubicación
- `PUT /api/auth/notificaciones/{usuarioId}` - Configurar notificaciones
- `GET /api/categorias/*` - Categorías
- `POST /api/reportes` - Crear reporte
- `POST /api/reportes/{id}/expandir` - Expandir reporte
- `POST /api/reportes/verificar-expansiones` - Verificar expansiones
- `PUT /api/reportes/{id}/resuelto` - Marcar como resuelto
- `POST /api/respuestas` - Crear respuesta
- `PUT /api/respuestas/{id}/bien` - Marcar como bien
- `PUT /api/respuestas/{id}/erroneo` - Marcar como erróneo
- `DELETE /api/respuestas/{id}` - Eliminar respuesta

---

### **Puerto 8001** - Lectura de Reportes ⚡ (MUY FRECUENTE)
**Propósito**: Consultas de lectura de reportes (endpoint más solicitado)

**Endpoints**:
- `GET /api/reportes/grupo/{grupoId}` - **MUY FRECUENTE** (más de 50% del tráfico)
- `GET /api/reportes/usuario/{usuarioId}` - Reportes del usuario
- `GET /api/reportes/{id}` - Ver reporte específico

**Optimización**: Este puerto maneja la mayor carga, ideal para optimizar con caché

---

### **Puerto 8002** - Notificaciones ⚡ (MUY FRECUENTE - POLLING)
**Propósito**: Polling constante de notificaciones

**Endpoints**:
- `GET /api/notificaciones/usuario/{usuarioId}/no-leidas` - **MUY FRECUENTE** (polling cada pocos segundos)
- `GET /api/notificaciones/usuario/{usuarioId}` - Todas las notificaciones
- `PUT /api/notificaciones/{id}/leida` - Marcar como leída
- `PUT /api/notificaciones/usuario/{id}/marcar-todas-leidas` - Marcar todas
- `DELETE /api/notificaciones/{id}` - Eliminar notificación
- `DELETE /api/notificaciones/usuario/{id}/eliminar-todas` - Eliminar todas

**Optimización**: Considera implementar WebSockets o Server-Sent Events en el futuro

---

### **Puerto 8003** - Geolocalización y Grupos 📍
**Propósito**: Consultas geográficas y gestión de grupos

**Endpoints**:
- `POST /api/cuadrantes/detectar` - Detectar cuadrante (FRECUENTE)
- `POST /api/cuadrantes/cercanos` - Cuadrantes cercanos (FRECUENTE)
- `GET /api/cuadrantes/*` - Otras operaciones de cuadrantes
- `POST /api/grupos/unir-automatico` - Unir a grupo (FRECUENTE)
- `POST /api/grupos/verificar-cambio-grupo` - Verificar cambio (FRECUENTE)
- `POST /api/grupos/por-cuadrantes` - Grupos por cuadrantes (FRECUENTE)
- `GET /api/grupos/usuario/{id}` - Grupos del usuario (FRECUENTE)
- `GET /api/grupos/*` - Otras operaciones de grupos

**Optimización**: Considera caché para consultas geográficas frecuentes

---

### **Puerto 8004** - Lectura de Respuestas 💬
**Propósito**: Consultas de lectura de respuestas

**Endpoints**:
- `GET /api/respuestas/reporte/{reporteId}` - Respuestas de un reporte (FRECUENTE)
- `GET /api/respuestas/reporte/{reporteId}/encontrado` - Solo tipo "encontrado"
- `GET /api/respuestas/{id}` - Ver respuesta específica

**Optimización**: Algunas consultas pueden ser lentas (~8s), considerar optimización de queries

---

## 🚀 Iniciar Servidores

### Windows
```bash
start-servers.bat
```

### Linux/Mac
```bash
chmod +x start-servers.sh
./start-servers.sh
```

### Manualmente (cada puerto)
```bash
# Puerto 8000 (default)
php artisan serve --host=192.168.100.58 --port=8000

# Puerto 8001
APP_ROUTES_FILE=api-8001.php php artisan serve --host=192.168.100.58 --port=8001

# Puerto 8002
APP_ROUTES_FILE=api-8002.php php artisan serve --host=192.168.100.58 --port=8002

# Puerto 8003
APP_ROUTES_FILE=api-8003.php php artisan serve --host=192.168.100.58 --port=8003

# Puerto 8004
APP_ROUTES_FILE=api-8004.php php artisan serve --host=192.168.100.58 --port=8004
```

---

## 📱 Actualizar Cliente/Frontend

Necesitarás actualizar tu cliente para usar los diferentes puertos:

```javascript
// Configuración de URLs por tipo de endpoint
const API_CONFIG = {
  // Puerto 8000: Operaciones críticas
  CRITICAL: 'http://192.168.100.58:8000/api',
  
  // Puerto 8001: Reportes
  REPORTS: 'http://192.168.100.58:8001/api',
  
  // Puerto 8002: Notificaciones
  NOTIFICATIONS: 'http://192.168.100.58:8002/api',
  
  // Puerto 8003: Geolocalización
  LOCATION: 'http://192.168.100.58:8003/api',
  
  // Puerto 8004: Respuestas
  ANSWERS: 'http://192.168.100.58:8004/api',
};

// Ejemplos de uso
// Login
fetch(`${API_CONFIG.CRITICAL}/auth/login`, {...});

// Obtener reportes del grupo
fetch(`${API_CONFIG.REPORTS}/reportes/grupo/${grupoId}`);

// Polling de notificaciones
fetch(`${API_CONFIG.NOTIFICATIONS}/notificaciones/usuario/${userId}/no-leidas`);

// Detectar cuadrante
fetch(`${API_CONFIG.LOCATION}/cuadrantes/detectar`, {...});

// Ver respuestas
fetch(`${API_CONFIG.ANSWERS}/respuestas/reporte/${reporteId}`);
```

---

## 🔧 Optimizaciones Recomendadas

### Puerto 8001 (Reportes) - Prioridad Alta
- ✅ Implementar caché Redis para reportes frecuentes
- ✅ Considerar paginación si no la hay
- ✅ Optimizar queries con índices en BD

### Puerto 8002 (Notificaciones) - Prioridad Alta
- ⚠️ **Problema detectado**: Polling constante causa latencias variables (0.15ms - 7s)
- 💡 **Solución recomendada**: Implementar WebSockets o Server-Sent Events
- ✅ Mientras tanto, separar en puerto dedicado ayuda

### Puerto 8003 (Geolocalización) - Prioridad Media
- ✅ Caché de consultas geográficas
- ✅ Algunos endpoints lentos (~17s) necesitan optimización

### Puerto 8004 (Respuestas) - Prioridad Media
- ⚠️ Algunas consultas muy lentas (~8s)
- ✅ Revisar queries y añadir índices

---

## 📊 Monitoreo

Monitorea los siguientes indicadores por puerto:
- **Puerto 8001**: Latencia promedio, peticiones por segundo
- **Puerto 8002**: Tiempo de respuesta del polling, frecuencia de polling
- **Puerto 8000**: Tiempo de respuesta de operaciones críticas
- **Puerto 8003**: Latencia de consultas geográficas
- **Puerto 8004**: Tiempo de consultas de respuestas

---

## ⚠️ Notas Importantes

1. **Compartir Sesión**: Todos los puertos comparten la misma base de datos y sesiones
2. **CORS**: Asegúrate de configurar CORS correctamente para todos los puertos
3. **Autenticación**: Los tokens de autenticación funcionan en todos los puertos
4. **Logs**: Cada puerto genera logs independientes

---

## 🐛 Solución de Problemas

### Error: "Route not found"
- Verifica que el archivo de rutas correspondiente existe en `routes/`
- Verifica que `APP_ROUTES_FILE` está configurado correctamente

### Servidor no inicia
- Verifica que el puerto no esté en uso: `netstat -ano | findstr :8001`
- Verifica permisos de archivos

### Cliente no puede conectar
- Verifica que el firewall permite los puertos
- Verifica que todos los servidores están corriendo

---

## 📝 Próximos Pasos

1. ✅ Implementar la separación de puertos
2. 🔄 Actualizar cliente/frontend
3. 📊 Monitorear rendimiento
4. 🚀 Optimizar queries lentas identificadas
5. 💡 Considerar WebSockets para notificaciones (Puerto 8002)

