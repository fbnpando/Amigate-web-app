<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RespuestaController;
use App\Http\Controllers\CategoriaController;

/*
|--------------------------------------------------------------------------
| API Routes - Puerto 8000: Operaciones de Escritura y Críticas
|--------------------------------------------------------------------------
| Autenticación, creación de reportes/respuestas, operaciones administrativas
*/

// ============================================
// AUTENTICACIÓN
// ============================================
Route::prefix('auth')->group(function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::get('perfil/{usuarioId}', [AuthController::class, 'perfil']);
    Route::put('perfil/{usuarioId}', [AuthController::class, 'actualizarPerfil']);
    Route::put('ubicacion/{usuarioId}', [AuthController::class, 'actualizarUbicacion']);
    Route::put('notificaciones/{usuarioId}', [AuthController::class, 'actualizarNotificaciones']);
});

// ============================================
// CATEGORÍAS (lectura simple, bajo volumen)
// ============================================
Route::prefix('categorias')->group(function () {
    Route::get('/', [CategoriaController::class, 'index']);
    Route::get('/{id}', [CategoriaController::class, 'show']);
});

// ============================================
// REPORTES - Operaciones de escritura
// ============================================
Route::prefix('reportes')->group(function () {
    // Verificar expansiones automáticas (ejecutar periódicamente)
    Route::post('verificar-expansiones', [ReporteController::class, 'verificarExpansionesAutomaticas']);
    
    // Crear reporte
    Route::post('/', [ReporteController::class, 'store']);
    
    // Expandir reporte manualmente
    Route::post('{reporteId}/expandir', [ReporteController::class, 'expandirReporte']);
    
    // 🧪 TESTING: Expandir reporte inmediatamente
    Route::post('{reporteId}/expandir-inmediato', [ReporteController::class, 'expandirInmediato']);
    
    // Marcar reporte como resuelto
    Route::put('{reporteId}/resuelto', [ReporteController::class, 'marcarResuelto']);
});

// ============================================
// RESPUESTAS - Operaciones de escritura
// ============================================
Route::prefix('respuestas')->group(function () {
    // Crear respuesta
    Route::post('/', [RespuestaController::class, 'store']);
    
    // Marcar respuesta como BIEN
    Route::put('{respuestaId}/bien', [RespuestaController::class, 'marcarBien']);
    
    // Marcar respuesta como ERRÓNEO
    Route::put('{respuestaId}/erroneo', [RespuestaController::class, 'marcarErroneo']);
    
    // Eliminar respuesta
    Route::delete('{id}', [RespuestaController::class, 'destroy']);
});

// ============================================
// RUTA DE PRUEBA
// ============================================
Route::get('/ping', function () {
    return response()->json([
        'success' => true,
        'message' => 'API Puerto 8000 funcionando correctamente',
        'timestamp' => now(),
        'port' => 8000
    ]);
});

