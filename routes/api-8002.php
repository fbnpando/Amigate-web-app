<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NotificacionController;

/*
|--------------------------------------------------------------------------
| API Routes - Puerto 8002: Notificaciones (MUY FRECUENTE - POLLING)
|--------------------------------------------------------------------------
| Optimizado para polling constante de notificaciones
*/

// ============================================
// NOTIFICACIONES
// ============================================
Route::prefix('notificaciones')->group(function () {
    // Obtener todas las notificaciones del usuario
    Route::get('usuario/{usuarioId}', [NotificacionController::class, 'index']);
    
    // Obtener notificaciones no leídas (MUY FRECUENTE - POLLING)
    Route::get('usuario/{usuarioId}/no-leidas', [NotificacionController::class, 'noLeidas']);
    
    // Marcar todas como leídas
    Route::put('usuario/{usuarioId}/marcar-todas-leidas', [NotificacionController::class, 'marcarTodasLeidas']);
    
    // Eliminar todas las notificaciones
    Route::delete('usuario/{usuarioId}/eliminar-todas', [NotificacionController::class, 'eliminarTodas']);
    
    // Marcar notificación como leída
    Route::put('{notificacionId}/leida', [NotificacionController::class, 'marcarLeida']);
    
    // Eliminar notificación
    Route::delete('{notificacionId}', [NotificacionController::class, 'destroy']);
});

// ============================================
// RUTA DE PRUEBA
// ============================================
Route::get('/ping', function () {
    return response()->json([
        'success' => true,
        'message' => 'API Puerto 8002 funcionando correctamente',
        'timestamp' => now(),
        'port' => 8002
    ]);
});

