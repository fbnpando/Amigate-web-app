<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\UsuarioController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\CuadranteController;
use App\Http\Controllers\CuadranteBarrioController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\ReporteCaracteristicaController;
use App\Http\Controllers\ReporteImagenController;
use App\Http\Controllers\ReporteVideoController;
use App\Http\Controllers\RespuestaController;
use App\Http\Controllers\RespuestaImagenController;
use App\Http\Controllers\RespuestaVideoController;
use App\Http\Controllers\GrupoController;
use App\Http\Controllers\ExpansionReporteController;
use App\Http\Controllers\NotificacionController;
use App\Http\Controllers\ConfiguracionNotificacionesUsuarioController;
use App\Http\Controllers\ConfiguracionSistemaController;
use App\Http\Controllers\GrupoMiembroController;
use App\Http\Controllers\NotificacionDatoController;

Route::post('login', [UsuarioController::class, 'login']);
Route::post('register', [UsuarioController::class, 'register']);

Route::apiResource('usuarios', UsuarioController::class);
Route::post('usuarios/{id}/ubicacion', [UsuarioController::class, 'actualizarUbicacion']);
Route::get('usuarios/{id}/reportes', [UsuarioController::class, 'reportes']);

Route::get('usuarios/{usuario}/notificaciones-config', [ConfiguracionNotificacionesUsuarioController::class, 'show']);
Route::post('usuarios/notificaciones-config', [ConfiguracionNotificacionesUsuarioController::class, 'store']);
Route::put('usuarios/{usuario}/notificaciones-config', [ConfiguracionNotificacionesUsuarioController::class, 'update']);

Route::apiResource('categorias', CategoriaController::class);
Route::match(['get', 'post'], 'cuadrantes/cercanos', [CuadranteController::class, 'obtenerCercanos']);
Route::post('cuadrantes/buscar', [CuadranteController::class, 'buscarPorCoordenadas']);
Route::apiResource('cuadrantes', CuadranteController::class);

Route::get('cuadrantes/{cuadrante}/barrios', [CuadranteBarrioController::class, 'index']);
Route::post('cuadrantes/{cuadrante}/barrios', [CuadranteBarrioController::class, 'store']);
Route::put('cuadrantes/{cuadrante}/barrios/{id}', [CuadranteBarrioController::class, 'update']);
Route::delete('cuadrantes/{cuadrante}/barrios/{id}', [CuadranteBarrioController::class, 'destroy']);

Route::apiResource('reportes', ReporteController::class);
Route::post('reportes/{id}/estado', [ReporteController::class, 'cambiarEstado']);
Route::post('reportes/cercanos', [ReporteController::class, 'buscarCercanos']);

Route::get('reportes/{reporte}/caracteristicas', [ReporteCaracteristicaController::class, 'index']);
Route::post('reportes/{reporte}/caracteristicas', [ReporteCaracteristicaController::class, 'store']);
Route::put('reportes/{reporte}/caracteristicas/{id}', [ReporteCaracteristicaController::class, 'update']);
Route::delete('reportes/{reporte}/caracteristicas/{id}', [ReporteCaracteristicaController::class, 'destroy']);

Route::get('reportes/{reporte}/imagenes', [ReporteImagenController::class, 'index']);
Route::post('reportes/{reporte}/imagenes', [ReporteImagenController::class, 'store']);
Route::put('reportes/{reporte}/imagenes/{id}', [ReporteImagenController::class, 'update']);
Route::delete('reportes/{reporte}/imagenes/{id}', [ReporteImagenController::class, 'destroy']);
Route::post('reportes/{reporte}/imagenes/reordenar', [ReporteImagenController::class, 'reordenar']);

Route::get('reportes/{reporte}/videos', [ReporteVideoController::class, 'index']);
Route::post('reportes/{reporte}/videos', [ReporteVideoController::class, 'store']);
Route::put('reportes/{reporte}/videos/{id}', [ReporteVideoController::class, 'update']);
Route::delete('reportes/{reporte}/videos/{id}', [ReporteVideoController::class, 'destroy']);
Route::post('reportes/{reporte}/videos/reordenar', [ReporteVideoController::class, 'reordenar']);

Route::get('reportes/{reporte}/respuestas', [RespuestaController::class, 'index']);
Route::post('reportes/{reporte}/respuestas', [RespuestaController::class, 'store']);
Route::put('reportes/{reporte}/respuestas/{id}', [RespuestaController::class, 'update']);
Route::delete('reportes/{reporte}/respuestas/{id}', [RespuestaController::class, 'destroy']);
Route::post('reportes/{reporte}/respuestas/{id}/verificar', [RespuestaController::class, 'marcarVerificada']);
Route::post('reportes/{reporte}/respuestas/{id}/util', [RespuestaController::class, 'marcarUtil']);

Route::get('respuestas/{respuesta}/imagenes', [RespuestaImagenController::class, 'index']);
Route::post('respuestas/{respuesta}/imagenes', [RespuestaImagenController::class, 'store']);
Route::delete('respuestas/{respuesta}/imagenes/{id}', [RespuestaImagenController::class, 'destroy']);

Route::get('respuestas/{respuesta}/videos', [RespuestaVideoController::class, 'index']);
Route::post('respuestas/{respuesta}/videos', [RespuestaVideoController::class, 'store']);
Route::delete('respuestas/{respuesta}/videos/{id}', [RespuestaVideoController::class, 'destroy']);

Route::get('reportes/{reporte}/expansiones', [ExpansionReporteController::class, 'index']);
Route::post('reportes/{reporte}/expansiones', [ExpansionReporteController::class, 'store']);
Route::post('reportes/{reporte}/expansiones/automatico', [ExpansionReporteController::class, 'expandirAutomatico']);
Route::delete('reportes/{reporte}/expansiones/{id}', [ExpansionReporteController::class, 'destroy']);

Route::post('grupos/por-cuadrantes', [GrupoController::class, 'obtenerPorCuadrantes']);
Route::apiResource('grupos', GrupoController::class);
Route::post('grupos/{id}/miembros', [GrupoController::class, 'agregarMiembro']);
Route::delete('grupos/{id}/miembros/{usuario}', [GrupoController::class, 'eliminarMiembro']);

Route::get('usuarios/{usuario}/notificaciones', [NotificacionController::class, 'index']);
Route::get('usuarios/{usuario}/notificaciones/no-leidas', [NotificacionController::class, 'noLeidas']);
Route::post('notificaciones', [NotificacionController::class, 'store']);
Route::post('notificaciones/{id}/leer', [NotificacionController::class, 'marcarLeida']);
Route::post('usuarios/{usuario}/notificaciones/leer-todas', [NotificacionController::class, 'marcarTodasLeidas']);
Route::delete('notificaciones/{id}', [NotificacionController::class, 'destroy']);

Route::apiResource('notificacion-datos', NotificacionDatoController::class);
Route::get('notificaciones/{notificacionId}/datos', [NotificacionDatoController::class, 'getByNotificacion']);

Route::get('configuracion', [ConfiguracionSistemaController::class, 'index']);
Route::get('configuracion/{clave}', [ConfiguracionSistemaController::class, 'show']);
Route::get('configuracion/{clave}/valor', [ConfiguracionSistemaController::class, 'obtenerValor']);
Route::post('configuracion', [ConfiguracionSistemaController::class, 'store']);
Route::put('configuracion/{clave}', [ConfiguracionSistemaController::class, 'update']);
Route::delete('configuracion/{clave}', [ConfiguracionSistemaController::class, 'destroy']);

Route::post('/grupos/{id}/miembros', [GrupoMiembroController::class, 'agregarMiembro']);
Route::get('/grupo-miembros', [GrupoMiembroController::class, 'index']);
Route::post('/grupo-miembros', [GrupoMiembroController::class, 'store']);
Route::get('/grupo-miembros/{id}', [GrupoMiembroController::class, 'show']);
Route::put('/grupo-miembros/{id}', [GrupoMiembroController::class, 'update']);
Route::delete('/grupo-miembros/{id}', [GrupoMiembroController::class, 'destroy']);

Route::get('/grupos/{grupoId}/miembros', [GrupoMiembroController::class, 'miembrosPorGrupo']);
Route::get('/usuarios/{usuarioId}/grupos', [GrupoMiembroController::class, 'gruposPorUsuario']);