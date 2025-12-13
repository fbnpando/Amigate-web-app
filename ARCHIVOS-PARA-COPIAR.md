# 📦 Archivos Necesarios para Migrar la API a un Nuevo Proyecto Laravel

## 🎯 Resumen
Lista completa de archivos que debes copiar para que la API funcione en un nuevo proyecto Laravel.

---

## 1️⃣ CONTROLADORES (app/Http/Controllers/)

### Carpeta: `app/Http/Controllers/Api/`
**TODOS los archivos de esta carpeta:**
- ✅ `Api/AuthController.php`
- ✅ `Api/CategoriaController.php`
- ✅ `Api/CuadranteController.php`
- ✅ `Api/GrupoController.php`
- ✅ `Api/NotificacionController.php`
- ✅ `Api/ReporteController.php`
- ✅ `Api/RespuestaController.php`

### Controlador Base:
- ✅ `Controller.php` (solo si no existe en el nuevo proyecto, o actualiza el existente)

---

## 2️⃣ MODELOS (app/Models/)

**TODOS los modelos necesarios:**
- ✅ `Categoria.php`
- ✅ `ConfiguracionNotificacionesUsuario.php`
- ✅ `ConfiguracionSistema.php`
- ✅ `Cuadrante.php`
- ✅ `CuadranteBarrio.php`
- ✅ `ExpansionReporte.php`
- ✅ `Grupo.php`
- ✅ `GrupoMiembro.php`
- ✅ `Notificacion.php`
- ✅ `NotificacionDato.php`
- ✅ `Reporte.php`
- ✅ `ReporteCaracteristica.php`
- ✅ `ReporteImagen.php`
- ✅ `ReporteVideo.php`
- ✅ `Respuesta.php`
- ✅ `RespuestaImagen.php`
- ✅ `RespuestaVideo.php`
- ✅ `Usuario.php` (¡IMPORTANTE! Reemplaza o actualiza el User.php del proyecto nuevo)

---

## 3️⃣ SERVICIOS (app/Services/)

- ✅ `ExpansionService.php` (si lo usas para expansión automática)

---

## 4️⃣ RUTAS (routes/)

**TODOS los archivos de rutas de la API:**
- ✅ `api.php` (ruta principal)
- ✅ `api-8000.php` (puerto 8000 - escritura)
- ✅ `api-8001.php` (puerto 8001 - lectura reportes)
- ✅ `api-8002.php` (puerto 8002 - notificaciones)
- ✅ `api-8003.php` (puerto 8003 - geolocalización)
- ✅ `api-8004.php` (puerto 8004 - lectura respuestas)

---

## 5️⃣ CONFIGURACIONES (config/)

- ✅ `multi-port.php` (si usas el sistema de puertos múltiples)

---

## 6️⃣ BOOTSTRAP (bootstrap/)

**⚠️ IMPORTANTE:** Actualiza `bootstrap/app.php` con la lógica de selección de rutas por puerto:

```php
// Determinar qué archivo de rutas API usar según el puerto
$apiRoutesFile = env('APP_ROUTES_FILE', 'api.php');
$apiRoutesPath = __DIR__.'/../routes/'.$apiRoutesFile;

// Si el archivo no existe, usar el default
if (!file_exists($apiRoutesPath)) {
    $apiRoutesPath = __DIR__.'/../routes/api.php';
}

return Application::configure(basePath: dirname(__DIR))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: $apiRoutesPath,  // ← Usar la variable aquí
        commands: __DIR__.'/../routes/console.php',
        channels: __DIR__.'/../routes/channels.php',
        health: '/up',
    )
    // ... resto del código
```

---

## 7️⃣ MIGRACIONES (database/migrations/)

**⚠️ CRÍTICO:** Necesitarás crear las migraciones para TODAS las tablas. 

**Tablas necesarias:**
1. `usuarios` (reemplaza/actualiza la tabla `users` estándar)
2. `categorias`
3. `cuadrantes`
4. `cuadrante_barrios`
5. `grupos`
6. `grupo_miembros`
7. `reportes`
8. `reporte_caracteristicas`
9. `reporte_imagenes`
10. `reporte_videos`
11. `respuestas`
12. `respuesta_imagenes`
13. `respuesta_videos`
14. `notificaciones`
15. `notificacion_datos`
16. `expansion_reportes`
17. `configuracion_sistema`
18. `configuracion_notificaciones_usuarios`

**💡 Recomendación:** Revisa los modelos para ver la estructura exacta de cada tabla (fillable, casts, relaciones).

---

## 8️⃣ EVENTOS (app/Events/) - OPCIONAL

- ⚠️ `NuevaNotificacion.php` - Si no existe, el código compilará pero el evento no funcionará.
  - Actualmente está referenciado en `NotificacionController.php` pero puede que no se use.

---

## 9️⃣ ENV (archivo .env)

**Variables de entorno a configurar:**
```env
APP_ROUTES_FILE=api.php  # o api-8000.php, api-8001.php, etc.
```

---

## 🔟 DEPENDENCIAS (composer.json)

**Verifica que tengas instalado:**
- `laravel/framework` (obvio)
- Cualquier otra dependencia que uses (revisa tu composer.json actual)

---

## ⚠️ PASOS IMPORTANTES DESPUÉS DE COPIAR:

1. **Ejecutar composer dump-autoload:**
   ```bash
   composer dump-autoload
   ```

2. **Crear las migraciones** si no las tienes (ver punto 7)

3. **Ejecutar migraciones:**
   ```bash
   php artisan migrate
   ```

4. **Configurar .env** con `APP_ROUTES_FILE` si usas múltiples puertos

5. **Verificar rutas:**
   ```bash
   php artisan route:list
   ```

6. **Revisar namespace de Usuario:** Si el nuevo proyecto usa `User` en lugar de `Usuario`, necesitarás:
   - Cambiar el modelo base `Authenticatable` o
   - Renombrar todas las referencias en los controladores

---

## 📋 CHECKLIST RÁPIDO:

- [ ] Controladores en `app/Http/Controllers/Api/`
- [ ] Todos los Modelos en `app/Models/`
- [ ] Servicios en `app/Services/` (si aplica)
- [ ] Todas las rutas en `routes/`
- [ ] Configuración `multi-port.php`
- [ ] Actualizar `bootstrap/app.php`
- [ ] Crear/ejecutar migraciones
- [ ] Configurar `.env`
- [ ] Ejecutar `composer dump-autoload`
- [ ] Probar las rutas con `php artisan route:list`

---

## 🚨 NOTAS IMPORTANTES:

1. **Usuario vs User:** Tu proyecto usa `Usuario` como modelo de autenticación. Asegúrate de configurar esto correctamente en el nuevo proyecto (config/auth.php).

2. **UUIDs:** Muchos modelos usan UUIDs (`HasUuids`). Asegúrate de que las migraciones usen `uuid()` o `string('id', 36)` como primary key.

3. **Base de datos:** Verifica que la estructura de la base de datos coincida exactamente con lo que esperan los modelos.

4. **Middleware:** Revisa si necesitas agregar middleware personalizado para autenticación u otras funcionalidades.

---

## 📝 ORDEN RECOMENDADO DE COPIA:

1. Primero: Modelos (para entender las relaciones)
2. Segundo: Controladores
3. Tercero: Rutas
4. Cuarto: Servicios (si aplica)
5. Quinto: Configuraciones
6. Sexto: Migraciones (crearlas basándote en los modelos)
7. Séptimo: Actualizar bootstrap/app.php
8. Octavo: Configurar .env
9. Noveno: Ejecutar composer dump-autoload
10. Décimo: Ejecutar migraciones y probar

---

¡Éxito con la migración! 🚀

